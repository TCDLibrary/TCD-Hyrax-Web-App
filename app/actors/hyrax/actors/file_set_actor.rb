module Hyrax
  module Actors
    # Actions are decoupled from controller logic so that they may be called from a controller or a background job.
    class FileSetActor
      include Lockable
      attr_reader :file_set, :user, :attributes

      require 'exifr/jpeg'
      require 'digest'

      def initialize(file_set, user)
        @file_set = file_set
        @user = user
      end

      # @!group Asynchronous Operations

      # Spawns asynchronous IngestJob unless ingesting from URL
      # Called from FileSetsController, AttachFilesToWorkJob, IngestLocalFileJob, ImportUrlJob
      # @param [Hyrax::UploadedFile, File] file the file uploaded by the user
      # @param [Symbol, #to_s] relation
      # @return [IngestJob, FalseClass] false on failure, otherwise the queued job
      def create_content(file, relation = :original_file, from_url: false)
        # If the file set doesn't have a title or label assigned, set a default.
        #byebug
        file_set.label ||= label_for(file)
        file_set.title = [file_set.label] if file_set.title.blank?
        #file_set.provenance << EXIFR::JPEG.new(file.file.to_s).model.to_s
        if File.extname(file.file.to_s) == ".jpg"
          file_set.camera_model = EXIFR::JPEG.new(file.file.to_s).model.to_s
          file_set.camera_make = EXIFR::JPEG.new(file.file.to_s).make.to_s
          file_set.date_taken = EXIFR::JPEG.new(file.file.to_s).date_time_original.to_s
          file_set.exposure_time = EXIFR::JPEG.new(file.file.to_s).exposure_time.to_s
          file_set.f_number = EXIFR::JPEG.new(file.file.to_s).f_number.to_s
          file_set.iso_speed_rating = EXIFR::JPEG.new(file.file.to_s).iso_speed_ratings.to_s
          file_set.flash = EXIFR::JPEG.new(file.file.to_s).flash.to_s
          file_set.exposure_program = EXIFR::JPEG.new(file.file.to_s).exposure_program.to_s
          file_set.focal_length = EXIFR::JPEG.new(file.file.to_s).focal_length.to_s
          file_set.software = EXIFR::JPEG.new(file.file.to_s).software.to_s
          file_set.fedora_sha1 = (Digest::SHA1.file file.file.to_s).to_s
        elsif File.extname(file.file.to_s) == ".tif"
          file_set.camera_model = EXIFR::TIFF.new(file.file.to_s).model.to_s
          file_set.camera_make = EXIFR::TIFF.new(file.file.to_s).make.to_s
          file_set.date_taken = EXIFR::TIFF.new(file.file.to_s).date_time_original.to_s
          file_set.exposure_time = EXIFR::TIFF.new(file.file.to_s).exposure_time.to_s
          file_set.f_number = EXIFR::TIFF.new(file.file.to_s).f_number.to_s
          file_set.iso_speed_rating = EXIFR::TIFF.new(file.file.to_s).iso_speed_ratings.to_s
          file_set.flash = EXIFR::TIFF.new(file.file.to_s).flash.to_s
          file_set.exposure_program = EXIFR::TIFF.new(file.file.to_s).exposure_program.to_s
          file_set.focal_length = EXIFR::TIFF.new(file.file.to_s).focal_length.to_s
          file_set.software = EXIFR::TIFF.new(file.file.to_s).software.to_s
          file_set.fedora_sha1 = (Digest::SHA1.file file.file.to_s).to_s
          file_set.visibility = 'restricted'
        end

        #byebug
        return false unless file_set.save # Need to save to get an id
        if from_url
          # If ingesting from URL, don't spawn an IngestJob; instead
          # reach into the FileActor and run the ingest with the file instance in
          # hand. Do this because we don't have the underlying UploadedFile instance
          file_actor = build_file_actor(relation)
          file_actor.ingest_file(wrapper!(file: file, relation: relation))
          # Copy visibility and permissions from parent (work) to
          # FileSets even if they come in from BrowseEverything
          VisibilityCopyJob.perform_later(file_set.parent) unless file_set.visibility == 'restricted'
          InheritPermissionsJob.perform_later(file_set.parent)
        else
          IngestJob.perform_later(wrapper!(file: file, relation: relation))
        end
      end

      # Spawns asynchronous IngestJob with user notification afterward
      # @param [Hyrax::UploadedFile, File, ActionDigest::HTTP::UploadedFile] file the file uploaded by the user
      # @param [Symbol, #to_s] relation
      # @return [IngestJob] the queued job
      def update_content(file, relation = :original_file)
      # JL: Cloned from Dean Farrell @ samvera slack
      # IngestJob.perform_later(wrapper!(file: file, relation: relation), notification: true)
        IngestJob.perform_now(wrapper!(file: file, relation: relation), notification: true)
      end

      # @!endgroup

      # Adds the appropriate metadata, visibility and relationships to file_set
      # @note In past versions of Hyrax this method did not perform a save because it is mainly used in conjunction with
      #   create_content, which also performs a save.  However, due to the relationship between Hydra::PCDM objects,
      #   we have to save both the parent work and the file_set in order to record the "metadata" relationship between them.
      # @param [Hash] file_set_params specifying the visibility, lease and/or embargo of the file set.
      #   Without visibility, embargo_release_date or lease_expiration_date, visibility will be copied from the parent.
      def create_metadata(file_set_params = {})
        file_set.depositor = depositor_id(user)
        now = TimeService.time_in_utc
        file_set.date_uploaded = now
        file_set.date_modified = now
        file_set.creator = [user.user_key]
        if assign_visibility?(file_set_params)
          env = Actors::Environment.new(file_set, ability, file_set_params)
          CurationConcern.file_set_create_actor.create(env)
        end
        yield(file_set) if block_given?
      end

      # Adds a FileSet to the work using ore:Aggregations.
      # Locks to ensure that only one process is operating on the list at a time.
      def attach_to_work(work, file_set_params = {})
        acquire_lock_for(work.id) do
          # Ensure we have an up-to-date copy of the members association, so that we append to the end of the list.
          work.reload unless work.new_record?
          file_set.visibility = work.visibility unless assign_visibility?(file_set_params) || file_set.visibility == 'restricted'
          work.ordered_members << file_set
          work.representative = file_set if work.representative_id.blank?
          work.thumbnail = file_set if work.thumbnail_id.blank?
          # Save the work so the association between the work and the file_set is persisted (head_id)
          # NOTE: the work may not be valid, in which case this save doesn't do anything.
          work.save
          Hyrax.config.callback.run(:after_create_fileset, file_set, user)
        end
      end
      alias attach_file_to_work attach_to_work
      deprecation_deprecate attach_file_to_work: "use attach_to_work instead"

      # @param [String] revision_id the revision to revert to
      # @param [Symbol, #to_sym] relation
      # @return [Boolean] true on success, false otherwise
      def revert_content(revision_id, relation = :original_file)
        return false unless build_file_actor(relation).revert_to(revision_id)
        Hyrax.config.callback.run(:after_revert_content, file_set, user, revision_id)
        true
      end

      def update_metadata(attributes)
        env = Actors::Environment.new(file_set, ability, attributes)
        CurationConcern.file_set_update_actor.update(env)
      end

      def destroy
        unlink_from_work
        hc = HyraxChecksum.find_by(:fileset_id => file_set.id)
        hc.update(deleted_by: user)
        file_set.destroy
        Hyrax.config.callback.run(:after_destroy, file_set.id, user)
      end

      class_attribute :file_actor_class
      self.file_actor_class = Hyrax::Actors::FileActor

      private

        def ability
          @ability ||= ::Ability.new(user)
        end

        def build_file_actor(relation)
          file_actor_class.new(file_set, relation, user)
        end

        # uses create! because object must be persisted to serialize for jobs
        def wrapper!(file:, relation:)
          JobIoWrapper.create_with_varied_file_handling!(user: user, file: file, relation: relation, file_set: file_set)
        end

        # For the label, use the original_filename or original_name if it's there.
        # If the file was imported via URL, parse the original filename.
        # If all else fails, use the basename of the file where it sits.
        # @note This is only useful for labeling the file_set, because of the recourse to import_url
        def label_for(file)
          if file.is_a?(Hyrax::UploadedFile) # filename not present for uncached remote file!
            file.uploader.filename.present? ? file.uploader.filename : File.basename(Addressable::URI.parse(file.file_url).path)
          elsif file.respond_to?(:original_name) # e.g. Hydra::Derivatives::IoDecorator
            file.original_name
          elsif file_set.import_url.present?
            # This path is taken when file is a Tempfile (e.g. from ImportUrlJob)
            File.basename(Addressable::URI.parse(file_set.import_url).path)
          else
            File.basename(file)
          end
        end

        def assign_visibility?(file_set_params = {})
          !((file_set_params || {}).keys.map(&:to_s) & %w[visibility embargo_release_date lease_expiration_date]).empty?
        end

        # replaces file_set.apply_depositor_metadata(user)from hydra-access-controls so depositor doesn't automatically get edit access
        def depositor_id(depositor)
          depositor.respond_to?(:user_key) ? depositor.user_key : depositor
        end

        # Must clear the fileset from the thumbnail_id, representative_id and rendering_ids fields on the work
        #   and force it to be re-solrized.
        # Although ActiveFedora clears the children nodes it leaves those fields in Solr populated.
        # rubocop:disable Metrics/CyclomaticComplexity
        def unlink_from_work
          work = file_set.parent
          return unless work && (work.thumbnail_id == file_set.id || work.representative_id == file_set.id || work.rendering_ids.include?(file_set.id))
          work.thumbnail = nil if work.thumbnail_id == file_set.id
          work.representative = nil if work.representative_id == file_set.id
          work.rendering_ids -= [file_set.id]
          work.save!
        end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/CyclomaticComplexity
    end
  end
end
