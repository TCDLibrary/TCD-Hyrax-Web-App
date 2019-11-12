class FoxmlImporter < ApplicationController
  include Hydra::Controller::ControllerBehavior
  include Blacklight::AccessControls::Catalog

  require 'fileutils'

  before_action :authenticate_user!
  before_action :ensure_admin!

  #$role_codes_contributor = {"ann" => "Annotator",
  #                          "asn" => "Associated Name",
  #                          "ato" => "Autographer",
  #                          "auc" => "Auctioneer" }

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end
  # TODO : Tidy up
  # TODO : Check all fields are present and populated/deduplicated properly
  # TODO : Run this offline? What happens to credentials then?
  # TODO : Allow Work, Folio or Collection to be parent_type
  # TODO : Validation, don't crash if file missing
  # TODO : Need to add logs. I want a list of Folios, and their IDs to be output

  # JL : 06/02/2019 Michelle asked me to remove deduplication for the following fields:
  #   Subject
  #   Language
  #   Identifier
  #   Date created
  #   Copyright status
  #   Medium
  #   Support
  #   Collection title
  #   Provenance
  #   Culture
  #   Description

  def initialize(object_model, user, file, parent = '000000000', parent_type = 'no_parent', image_type = 'LO', visibility = 'Public', base_folder = Rails.application.config.ingest_folder)
    @file = file
    #@user = ::User.batch_user
    @user = user
    @parent = parent
    @parent_type = parent_type
    @base_folder = base_folder
    #byebug
    @image_type = image_type
    @file_path = base_folder + file
    @filename = file
    @object_model = object_model
    @visibility = visibility
    # @artefact = artefact
  end

  require 'nokogiri'
  require 'open-uri'

  def import(artefactClass)

      admin_set_id =  AdminSet.find_or_create_default_admin_set_id

      if @parent_type == "collection"
        #coll_owner_rec = Collection.new
        begin
          coll_owner_rec = Collection.find(@parent)
        rescue

        end
      end

      if @parent_type == "work"
        owner_rec = Work.new
        begin
          owner_rec = Work.find(@parent)
        rescue

        end
      else
        if @parent_type == "folio"
          owner_rec = Folio.new
          begin
            owner_rec = Folio.find(@parent)
          rescue

          end
        else if @parent_type == "subseries"
                owner_rec = Subseries.new
                begin
                  owner_rec = Subseries.find(@parent)
                rescue

                end
          #  else
          #    owner_rec = Work.new
            end
         end
      end

      Rails.logger.info "*** Begin Ingesting #{artefactClass} file #{@file_path}. =>TCD<="

      #byebug
      # Fetch and parse HTML document
      #doc = Nokogiri::XML(open("spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml"))
      doc = Nokogiri::XML(open(@file_path))
      puts "### Search for nodes by xpath"

      #byebug
      doc.xpath("//xmlns:ROW").each do |link|

        artefact = artefactClass.new
        #artefact = Folio.new
        artefact.depositor = @user.email
        # byebug
        if @visibility == 'Private'
          artefact.visibility = 'restricted'
        else
          artefact.visibility = 'open'
        end

        artefact.admin_set_id = admin_set_id
        #byebug

        self.parse(link, artefact, owner_rec)

        if @image_type == 'HI' || @image_type == 'LO' || @image_type == 'TIFF' || @image_type == 'HI and TIFF'
            if @object_model == "Single Object, Multiple Images"
                # image file names are derived from CatNo + wildcard
                imageWildcard = ""
                link.xpath("xmlns:CatNo").each do |catNo|
                  if !catNo.content.blank?
                    imageWildcard = catNo.content.to_s
                  end
                end

                imageRangeLow = ""
                imageRangeHi = ""
                fileRange = []

                link.xpath("xmlns:ImgRange").each do |imgRange|
                  if !imgRange.content.blank?

                    rangeArray = imgRange.content.to_s.split(':')

                    if rangeArray.count > 1
                      imageRangeLow = rangeArray[0]
                      imageRangeHi = rangeArray[1]
                      fileRange = (imageRangeLow..imageRangeHi).to_a
                    end

                  end
                end
                # byebug

                imageLocation = []

                if @image_type == 'LO'
                  image_sub_folder = artefact.folder_number.first + '/LO/'
                  imageFolderName = @base_folder + image_sub_folder
                  if fileRange.count == 0
                    fileName = imageFolderName + imageWildcard + "*"
                    imageLocation = imageLocation + Dir[fileName].sort
                  else
                    myDir = Dir[@base_folder + artefact.folder_number.first + '/LO/*']
                    fileRange.each do | aFileNum |
                      fileName = imageFolderName + imageWildcard + '_' + aFileNum + '_LO.jpg'
                      if myDir.include?(fileName)
                        imageLocation << fileName
                      end
                      # byebug
                    end
                  end
                end
                # JOE: Could check Dir[fileName] to see if the numbered file exists.
                # myDir = Dir[@base_folder + artefact.folder_number.first + '/HI/*']
                # myDir.include?(fileName)
                if @image_type == 'HI' || @image_type == 'HI and TIFF'
                  image_sub_folder = artefact.folder_number.first + '/HI/'
                  imageFolderName = @base_folder + image_sub_folder
                  if fileRange.count == 0
                    fileName = imageFolderName + imageWildcard + "*"
                    imageLocation = imageLocation + Dir[fileName].sort
                  else
                    myDir = Dir[@base_folder + artefact.folder_number.first + '/HI/*']
                    fileRange.each do | aFileNum |
                      fileName = imageFolderName + imageWildcard + '_' + aFileNum + '_HI.jpg'
                      if myDir.include?(fileName)
                        imageLocation << fileName
                      end
                      # byebug
                    end
                  end
                end

                if @image_type == 'TIFF' || @image_type == 'HI and TIFF'
                  image_sub_folder = artefact.folder_number.first + '/TIF/'
                  imageFolderName = @base_folder + image_sub_folder
                  if fileRange.count == 0
                    fileName = imageFolderName + imageWildcard + "*"
                    imageLocation = imageLocation + Dir[fileName].sort
                  else
                    myDir = Dir[@base_folder + artefact.folder_number.first + '/TIF/*']
                    fileRange.each do | aFileNum |
                      fileName = imageFolderName + imageWildcard + '_' + aFileNum + '.tif'
                      if myDir.include?(fileName)
                        imageLocation << fileName
                      end
                      # byebug
                    end
                  end
                end

                # byebug
            else
                # @object_model is "Multiple Objects, One Image Each"
                # image file name is in DRISPhotoID
                imageFileName = ""
                imageFilePrefix = ""
                link.xpath("xmlns:DRISPhotoID").each do |drisPhotoId|
                  if !drisPhotoId.content.blank?
                    imageFilePrefix = drisPhotoId.content.to_s
                  end
                end

                imageLocation = []

                if @image_type == 'LO'
                    imageFileName = imageFilePrefix + "_LO.jpg"
                    image_sub_folder = imageFilePrefix + '/LO/'
                    imageLocation << @base_folder + image_sub_folder + imageFileName
                end

                if @image_type == 'HI' || @image_type == 'HI and TIFF'
                    imageFileName = imageFilePrefix + "_HI.jpg"
                    image_sub_folder = artefact.folder_number.first + '/HI/'
                    imageLocation << @base_folder + image_sub_folder + imageFileName
                end

                if @image_type == 'TIFF' || @image_type == 'HI and TIFF'
                    imageFileName = imageFilePrefix + ".tif"
                    # byebug
                    image_sub_folder = artefact.folder_number.first + '/TIF/'
                    imageLocation << @base_folder + image_sub_folder + imageFileName
                end

            end
            #byebug
            uploaded_files = []
            # byebug
            begin
              imageLocation.each do | oneImage |
                  artefact_binary = File.open("#{oneImage}")
                  uploaded_files << Hyrax::UploadedFile.create(user: @user, file: artefact_binary)
              end
            rescue
              imageLocation = [@base_folder + 'HI/' + 'fa-file.jpg']
              imageLocation.each do | oneImage |
                  artefact_binary = File.open("#{oneImage}")
                  uploaded_files << Hyrax::UploadedFile.create(user: @user, file: artefact_binary)
              end
            end
            # byebug
            fileMap = uploaded_files.map do | aFile |
                        aFile.id
                      end
            #byebug
            attributes_for_actor = { uploaded_files: fileMap }
            env = Hyrax::Actors::Environment.new(artefact, ::Ability.new(@user), attributes_for_actor)
            Hyrax::CurationConcern.actor.create(env)
        else
            imageLocation = [@base_folder + 'HI/' + 'fa-file.jpg']
            uploaded_files = []
            imageLocation.each do | oneImage |
                artefact_binary = File.open("#{oneImage}")
                uploaded_files << Hyrax::UploadedFile.create(user: @user, file: artefact_binary)
            end
            # byebug
            fileMap = uploaded_files.map do | aFile |
                        aFile.id
                      end

            attributes_for_actor = { uploaded_files: fileMap }
            env = Hyrax::Actors::Environment.new(artefact, ::Ability.new(@user), attributes_for_actor)
            Hyrax::CurationConcern.actor.create(env)

        end

        if artefact.creator.empty?
          artefact.creator = ['Unattributed']
        end

        if artefact.keyword.empty?
          artefact.keyword = ['Unassigned']
        end

        artefact.save

        if owner_rec.present? && owner_rec.id != '000000000'
           owner_rec.members << artefact
           owner_rec.ordered_members << artefact
           owner_rec.save
        end

        if coll_owner_rec.present? && coll_owner_rec.id != '000000000'
           artefact.member_of_collections << coll_owner_rec
           artefact.save
        end

      Rails.logger.info "*** End Ingesting #{artefact.class} file #{@file_path}. =>TCD<="

      end

      if Rails.env != "test"
        archive_folder = @base_folder + Date.today.to_s + '_ingested_xml_files'
        if Dir.exists?(archive_folder)
          dest_file_path = archive_folder + '/' + @filename
          FileUtils.mv(@file_path, dest_file_path)
        else
          FileUtils.mkdir(archive_folder)
          dest_file_path = archive_folder + '/' + @filename
          FileUtils.mv(@file_path, dest_file_path)
        end
      end


  end

  def parse(link, artefact, owner_rec)

      #byebug
      # title -> Title
      link.xpath("xmlns:Title").each do |aTitle|
        if !aTitle.content.blank?
          artefact.title = [aTitle.content]
        end
      end

      # folder_number -> ProjectName
      link.xpath("xmlns:ProjectName").each do |projectName|
        if !projectName.content.blank?
          artefact.folder_number = [projectName.content]
        end
      end

      # dris_document_no -> DRISPhotoID
      link.xpath("xmlns:DRISPhotoID").each do |drisPhotoId|
        if !drisPhotoId.content.blank?
          artefact.dris_document_no = [drisPhotoId.content]
        end
      end

      # contributor -> AttributedArtist
      link.xpath("xmlns:AttributedArtist").each do |anArtist|
        if !anArtist.content.blank?
          anArtist.xpath("xmlns:DATA").each do |individual|
            if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.creator_loc.include?(individual.content)))
              artefact.creator_loc.push(individual.content)
            end
          end
        end
      end

      # creator_local -> OtherArtist
      link.xpath("xmlns:OtherArtist").each do |anArtist|
        if !anArtist.content.blank?
          anArtist.xpath("xmlns:DATA").each do |individual|
            if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.creator_local.include?(individual.content)))
              artefact.creator_local.push(individual.content)
            end
          end
        end
      end

      # creator -> AttributedArtistCalculation
      link.xpath("xmlns:AttributedArtistCalculation").each do |anArtist|
        if !anArtist.content.blank?
          anArtist.xpath("xmlns:DATA").each do |individual|

            # parse each AttributedArtistCalculation on ';' expecting 3 data fields
            indivArtistCalc = individual.content
            indivParts = indivArtistCalc.split(';')

            name = ''
            role = ''
            roleCode = ''
            dataToIngest = ''
            # loop through the sub array and check the key before choosing the value
            indivParts.each do | indivBlob |
              # parse the part with ':' to get key/value pair
              calcVal = indivBlob.split(': ')

              if calcVal.count > 1
                if calcVal[0] == 'AttributedArtistRoleCode'
                  roleCode = calcVal[1]
                else if calcVal[0] == ' Attributed Artist'
                       name = calcVal[1]
                     else if calcVal[0] == 'AttributedArtistRole'
                             role = calcVal[1]
                          end
                     end
                end
              end

            end
            #
            dataToIngest = name + ', ' + role
            if !dataToIngest.blank?
              if Role_codes_creator.include?(roleCode)
                 artefact.creator.push(dataToIngest)
              else if Role_codes_contributor.include?(roleCode)
                      artefact.contributor.push(dataToIngest)
                   else if Role_codes_subject.include?(roleCode)
                           artefact.subject.push(dataToIngest)
                        end
                   end
              end

              if Role_codes_donor.include?(roleCode)
                 artefact.provenance.push(dataToIngest)
              end
            end

          end
        end
      end

      # creator -> AttributedArtistCalculation
      link.xpath("xmlns:OtherArtistCalculation").each do |anArtist|
        if !anArtist.content.blank?
          anArtist.xpath("xmlns:DATA").each do |individual|

            # parse each AttributedArtistCalculation on ';' expecting 3 data fields
            indivArtistCalc = individual.content
            indivParts = indivArtistCalc.split(';')

            name = ''
            role = ''
            roleCode = ''
            dataToIngest = ''
            # loop through the sub array and check the key before choosing the value
            indivParts.each do | indivBlob |
              # parse the part with ':' to get key/value pair
              calcVal = indivBlob.split(': ')

              if calcVal.count > 1
                if calcVal[0] == ' OtherArtistRoleCode'
                  roleCode = calcVal[1]
                else if calcVal[0] == ' OtherArtist'
                       name = calcVal[1]
                     else if calcVal[0] == 'OtherArtistRole'
                             role = calcVal[1]
                          end
                     end
                end
              end

            end

            dataToIngest = name + ', ' + role
            if !dataToIngest.blank?
              if Role_codes_creator.include?(roleCode)
                 artefact.creator.push(dataToIngest)
              else if Role_codes_contributor.include?(roleCode)
                      artefact.contributor.push(dataToIngest)
                   else if Role_codes_subject.include?(roleCode)
                           artefact.subject.push(dataToIngest)
                        end
                   end
              end

              if Role_codes_donor.include?(roleCode)
                 artefact.provenance.push(dataToIngest)
              end

            end

          end
        end
      end

      # genre -> SubjectTMG
      link.xpath("xmlns:SubjectTMG").each do |subjects|
        if !subjects.content.blank?
          subjects.xpath("xmlns:DATA").each do |aSubject|
            artefact.genre.push(aSubject.content)
            artefact.genre_tgm.push(aSubject.content)
          end
        end
      end

      # rights_statement -> CopyrightStatus
      link.xpath("xmlns:CopyrightStatus").each do |statuses|
         if !statuses.content.blank?
           statuses.xpath("xmlns:DATA").each do |aStatus|
             if aStatus.content == "Active"
               artefact.rights_statement = ["Active - In Copyright"]
             else if aStatus.content == "Expired"
                    artefact.rights_statement = ["Expired - Public Domain (Creative Commons)"]
                  else if aStatus.content == "Orphan"
                         artefact.rights_statement = ["Orphan - In Copyright - EU Orphan Work"]
                       else artefact.rights_statement = ["Uncertain - Copyright Undetermined"]
                       end
                  end
             end
           end
         end
      end

      # abstract
      #byebug
      link.xpath("xmlns:Abstract").each do |abstract|
        if !abstract.content.blank?
           if (abstract.content.length > 200)
              artefact.description = [(abstract.content.slice(0..200) + '...')]
           else
              artefact.description = [abstract.content]
           end
           artefact.abstract = [abstract.content]
        end
      end

      # publisher
      link.xpath("xmlns:Publisher").each do |publisher|
        if !publisher.content.blank?

          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.publisher.include?(publisher.content)))
             artefact.publisher = [publisher.content]
          end
        end
      end

      # date created
      link.xpath("xmlns:DateCalculation").each do |calcDates|
        if !calcDates.content.blank?
          crArray = Array.new(3)
          calcDates.xpath("xmlns:DATA").each do |aCalcDate|
              aCalcDate.content = aCalcDate.content.sub('DateType: ', '')
              aCalcDate.content = aCalcDate.content.sub('Day: ', '')
              aCalcDate.content = aCalcDate.content.sub(' A.D.', '')
              # input date order is random so need to tidy it up so start end before end date.
              # element[2] is safety net in case input format not what we expect.

              if aCalcDate.content.include?("start")
                crArray[0] = aCalcDate.content
              else if aCalcDate.content.include?("end")
                      crArray[1] = aCalcDate.content
                   else crArray[2] = aCalcDate.content
                   end
              end
           end
           # remove any null elements
           crArray = crArray.compact
           dCre = ""
           crArray.each do | cr |
              dCre += cr + " "
           end
           #if crArray.length > 0
           #byebug
           dCre = dCre.sub("--", "")
           artefact.date_created.push(dCre)
           #end
        end
      end

      # language
      link.xpath("xmlns:Language").each do |languages|
        if !languages.content.blank?
          languages.xpath("xmlns:DATA").each do |aLanguage|
            artefact.language.push(aLanguage.content)
          end
        end
      end

      # location
      link.xpath("xmlns:Location").each do |location|
        if !location.content.blank?
          location.xpath("xmlns:DATA").each do |aLocation|
            if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.location.include?(aLocation.content)))
               artefact.location.push(aLocation.content)
            end
          end
        end
      end

      # resource_type
      link.xpath("xmlns:Type").each do |aType|
        if !aType.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.resource_type.include?(aType.content)))
             artefact.resource_type = [aType.content]
          end
        end
      end

      # genre -> TypeOfWork
      link.xpath("xmlns:TypeOfWork").each do |aTypeOfWork|
        if !aTypeOfWork.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.genre.include?(aTypeOfWork.content)))
             artefact.genre.push(aTypeOfWork.content)
          end
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.genre_aat.include?(aTypeOfWork.content)))
             artefact.genre_aat.push(aTypeOfWork.content)
          end
        end
      end

      # bibliography
      link.xpath("xmlns:Bibliography").each do |aBibliography|
        if !aBibliography.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.bibliography.include?(aBibliography.content)))
             artefact.bibliography = [aBibliography.content]
          end
        end
      end

      # dris_page_no
      if artefact.class == Folio || artefact.class == Subseries
          link.xpath("xmlns:DrisPageNo").each do |aDrisPageNo|
            if !aDrisPageNo.content.blank?
              if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.dris_page_no.include?(aDrisPageNo.content)))
                 artefact.dris_page_no = [aDrisPageNo.content]
              end
            end
          end
      end

      # dris_document_no
      link.xpath("xmlns:DrisDocumentNo").each do |aDrisDocumentNo|
        if !aDrisDocumentNo.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.dris_document_no.include?(aDrisDocumentNo.content)))
             artefact.dris_document_no = [aDrisDocumentNo.content]
          end
        end
      end

      # dris_unique
      link.xpath("xmlns:DrisUnique").each do |aDrisUnique|
        if !aDrisUnique.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.dris_unique.include?(aDrisUnique.content)))
            artefact.dris_unique = [aDrisUnique.content]
          end
        end
      end

      # format_duration
      link.xpath("xmlns:FormatDur").each do |aFormatDuration|
        if !aFormatDuration.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.format_duration.include?(aFormatDuration.content)))
             artefact.format_duration = [aFormatDuration.content]
          end
        end
      end

      # copyright_status
      link.xpath("xmlns:CopyrightHolder").each do |copyrightHolders|
        if !copyrightHolders.content.blank?
          copyrightHolders.xpath("xmlns:DATA").each do |aCopyrightHolder|
            artefact.copyright_status.push(aCopyrightHolder.content)
          end
        end
      end

      # copyright_note
      link.xpath("xmlns:CopyrightNotes").each do |copyrightNotes|
        if !copyrightNotes.content.blank?
          copyrightNotes.xpath("xmlns:DATA").each do |aCopyrightNote|
            if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.copyright_note.include?(aCopyrightNote.content)))
               artefact.copyright_note.push(aCopyrightNote.content)
            end
          end
        end
      end

      # digital_root_number -> CatNo
      link.xpath("xmlns:CatNo").each do |aDigitalRootNumber|
        if !aDigitalRootNumber.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.digital_root_number.include?(aDigitalRootNumber.content)))
             artefact.digital_root_number = [aDigitalRootNumber.content]
          end
        end
      end

      # digital_object_identifier -> DRISPhotoID
      if artefact.class == Folio || artefact.class == Subseries
          link.xpath("xmlns:DRISPhotoID").each do |aDigitalObjectId|
            if !aDigitalObjectId.content.blank?
              if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.digital_object_identifier.include?(aDigitalObjectId.content)))
                 artefact.digital_object_identifier = [aDigitalObjectId.content]
              end
            end
          end
      end

      # location_type -> LocationType
      link.xpath("xmlns:LocationType").each do |locationTypes|
        if !locationTypes.content.blank?
          locationTypes.xpath("xmlns:DATA").each do |aLocationType|
            if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.location_type.include?(aLocationType.content)))
              artefact.location_type.push(aLocationType.content)
            end
          end
        end
      end

      # shelf_locator -> Citation
      link.xpath("xmlns:Citation").each do |aCitation|
        if !aCitation.content.blank?
           artefact.identifier = [aCitation.content]
        end
      end

      # sponsor -> Sponsor
      link.xpath("xmlns:Sponsor").each do |aSponsor|
        if !aSponsor.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.sponsor.include?(aSponsor.content)))
             artefact.sponsor.push(aSponsor.content)
          end
        end
      end

      # conservation_history -> Introduction
      link.xpath("xmlns:Introduction").each do |aConsHist|
        if !aConsHist.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.conservation_history.include?(aConsHist.content)))
             artefact.conservation_history.push(aConsHist.content)
          end
        end
      end

      # publisher_location -> PublisherCity; PublisherCountry
      link.xpath("xmlns:PublisherCity").each do |aPublisherLoc|
        if !aPublisherLoc.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.publisher_location.include?(aPublisherLoc.content)))
             artefact.publisher_location.push(aPublisherLoc.content)
          end
        end
      end
      link.xpath("xmlns:PublisherCountry").each do |aPublisherLoc|
        if !aPublisherLoc.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.publisher_location.include?(aPublisherLoc.content)))
             artefact.publisher_location.push(aPublisherLoc.content)
          end
        end
      end

      # page_number -> PageNo; PageNoB
      link.xpath("xmlns:PageNo").each do |aPageNo|
        if !aPageNo.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.page_number.include?(aPageNo.content)))
             artefact.page_number.push(aPageNo.content)
          end
        end
      end
      link.xpath("xmlns:PageNoB").each do |aPageNo|
        if !aPageNo.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.page_number.include?(aPageNo.content)))
             artefact.page_number.push(aPageNo.content)
          end
        end
      end

      # page_type -> PageType; PageTypeB
      link.xpath("xmlns:PageType").each do |aPageType|
        if !aPageType.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.page_type.include?(aPageType.content)))
             artefact.page_type.push(aPageType.content)
          end
        end
      end
      link.xpath("xmlns:PageTypeB").each do |aPageType|
        if !aPageType.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.page_type.include?(aPageType.content)))
             artefact.page_type.push(aPageType.content)
          end
        end
      end

      # physical_extent -> FormatW
      link.xpath("xmlns:FormatW").each do |aPhysicalExtent|
        if !aPhysicalExtent.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.physical_extent.include?(aPhysicalExtent.content)))
             artefact.physical_extent.push(aPhysicalExtent.content)
          end
        end
      end

      # support and medium are mapped in reverse in xml
      link.xpath("xmlns:Medium").each do |supports|
        if !supports.content.blank?
          supports.xpath("xmlns:DATA").each do |aSupport|
            artefact.support.push(aSupport.content)
          end
        end
      end

      # medium and support are mapped in reverse in xml
      link.xpath("xmlns:Support").each do |mediums|
        if !mediums.content.blank?
          mediums.xpath("xmlns:DATA").each do |aMedium|
            artefact.medium.push(aMedium.content)
          end
        end
      end

      # subject_lcsh -> SubjectLCSH
      link.xpath("xmlns:SubjectLCSH").each do |subjects|
        if !subjects.content.blank?
          subjects.xpath("xmlns:DATA").each do |aSubject|
            artefact.subject.push(aSubject.content)
            artefact.subject_lcsh.push(aSubject.content)
          end
        end
      end

      # subject_local -> OpenKeyword
      link.xpath("xmlns:OpenKeyword").each do |subjects|
        if !subjects.content.blank?
          subjects.xpath("xmlns:DATA").each do |aSubject|
            if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.keyword.include?(aSubject.content)))
               artefact.keyword.push(aSubject.content)
            end
            if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.subject_local_keyword.include?(aSubject.content)))
               artefact.subject_local_keyword.push(aSubject.content)
            end
          end
        end
      end

      # subject_name -> LCSubjectNames
      link.xpath("xmlns:LCSubjectNames").each do |subjects|
        if !subjects.content.blank?
          subjects.xpath("xmlns:DATA").each do |aSubject|
             artefact.subject.push(aSubject.content)
             artefact.subject_subj_name.push(aSubject.content)
          end
        end
      end

      # alternative_title -> OtherTitle
      link.xpath("xmlns:OtherTitle").each do |titles|
        if !titles.content.blank?
          titles.xpath("xmlns:DATA").each do |aTitle|
            if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.alternative_title.include?(aTitle.content)))
               artefact.alternative_title.push(aTitle.content)
            end
          end
        end
      end

      # series_title -> SeriesReportNo
      link.xpath("xmlns:SeriesReportNo").each do |titles|
        if !titles.content.blank?
          titles.xpath("xmlns:DATA").each do |aTitle|
            if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.series_title.include?(aTitle.content)))
               artefact.series_title.push(aTitle.content)
            end
          end
        end
      end

      # collection_title -> TitleLargerEntity
      link.xpath("xmlns:TitleLargerEntity").each do |aTitle|
        if !aTitle.content.blank?
           artefact.collection_title.push(aTitle.content)
        end
      end

      # provenance
      link.xpath("xmlns:Provenance").each do |aProvenance|
        if !aProvenance.content.blank?
           artefact.provenance.push(aProvenance.content)
        end
      end

      # culture -> Culture
      link.xpath("xmlns:Culture").each do |cultures|
        if !cultures.content.blank?
          cultures.xpath("xmlns:DATA").each do |aCulture|
            artefact.culture.push(aCulture.content)
          end
        end
      end

      # county -> CALM
      link.xpath("xmlns:CALM").each do |calmRef|
        if !calmRef.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.county.include?(calmRef.content)))
             artefact.county.push(calmRef.content)
          end
        end
      end

      # project_number
      link.xpath("xmlns:ProjectNo").each do |projNo|
        if !projNo.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.project_number.include?(projNo.content)))
             artefact.project_number.push(projNo.content)
          end
        end
      end

      # order_no -> LCN
      link.xpath("xmlns:LCN").each do |orderNo|
        if !orderNo.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.order_no.include?(orderNo.content)))
             artefact.order_no.push(orderNo.content)
          end
        end
      end

      # total_records
      link.xpath("xmlns:PageTotal").each do |totalRecs|
        if !totalRecs.content.blank?
          if (!owner_rec.present?) || (owner_rec.present? && !(owner_rec.total_records.include?(totalRecs.content)))
             artefact.total_records.push(totalRecs.content)
          end
        end
      end

  end

end
