module Hyrax
  # Creates fixity status messages to display to user, for a fileset.
  # Determines status by looking up existing recorded ChecksumAuditLog objects,
  # does not actually do a check itself.
  #
  # See FileSetFixityCheckService and ChecksumAuditLog for actually performing
  # checks and recording as ChecksumAuditLog objects.
  class FixityStatusPresenter
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::OutputSafetyHelper

    attr_reader :file_set_id
    # Note this takes a file_set_id NOT a FileSet, easy use from either solr
    # or AF object.
    def initialize(file_set_id)
      @file_set_id = file_set_id
    end

    # Returns a html_safe string communicating fixity status checks,
    # possibly on multiple files/versions.
    def render_file_set_status
      @file_set_status ||=
        if relevant_log_records.empty?
          "Fixity checks have not yet been run on this object"
        elsif failing_checks.empty?
          content_tag("span", "passed", class: "label label-success") + ' ' + render_existing_check_summary
        else
          content_tag("span", "FAIL", class: "label label-danger") + ' ' + render_existing_check_summary + render_failed_compact
        end
    end

    # sends back '', 'pass', or 'fail'. Used in fixity audit process
    def check_file_set_status
      @fixity_status ||=
        if relevant_log_records.empty?
          ""
        elsif failing_checks.empty?
          "pass"
        else
          "fail"
        end
    end

    protected

      # A weird display, cause we need it to fit in that 180px column on
      # FileSet show, and have no real UI to link to for files/versions :(
      # rubocop:disable Metrics/MethodLength
      def render_failed_compact
        safe_join(
          ["<p><strong>Failed checks:</strong></p>".html_safe] +
          failing_checks.collect do |log|
            safe_join(
              [
                "<p>".html_safe,
                "ChecksumAuditLog id: #{log.id}; ",
                content_tag("a", "file", href: "#{Hydra::PCDM::File.translate_id_to_uri.call(log.file_id)}/fcr:metadata") + "; ",
                content_tag("a", "checked_uri", href: "#{log.checked_uri}/fcr:metadata") + "; ",
                "date: #{log.created_at}; ",
                "expected_result: #{log.expected_result}",
                "</p>".html_safe
              ]
            )
          end
        )
      end
      # rubocop:enable Metrics/MethodLength

      def render_existing_check_summary
        @render_existing_check_summary ||=
          "#{pluralize num_checked_files, 'File'} with #{pluralize relevant_log_records.count, 'total version'} checked #{render_date_range}"
      end

      def render_date_range
        @render_date_range ||= begin
          from = relevant_log_records.min_by(&:created_at).created_at.to_s
          to   = relevant_log_records.max_by(&:created_at).created_at.to_s
          if from == to
            from
          else
            "between #{from} and #{to}"
          end
        end
      end

      # Should be all _latest_ ChecksumAuditLog about different files/versions
      # currently existing in specified FileSet.
      def relevant_log_records
        @relevant_log_records ||= ChecksumAuditLog.latest_for_file_set_id(file_set_id)
      end

      def num_checked_files
        @num_relevant_files ||= relevant_log_records.group_by(&:file_id).keys.count
      end

      def failing_checks
        @failing_checks ||= relevant_log_records.find_all(&:failed?)
      end
  end
end
