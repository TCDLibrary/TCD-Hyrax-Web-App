class FixityAuditJob < ApplicationJob
  queue_as :fixity

  def perform(*args)
    # Do something later:

    # What week number is this?
    week_no = Date.today.strftime("%U").to_s

    # Read fixity table for week Number
    @hyrax_checksums = HyraxChecksum.weekly(week_no)

    @hyrax_checksums.each do | hyrax_checksum |
        fs = FileSet.find(hyrax_checksum.fileset_id)
        fs.files.each do | a_file |
          # byebug
          FixityCheckJob.perform_now(a_file.uri, file_set_id:fs.id, file_id:a_file.id)
        end
    end

    # send email
    FixityAuditMailer.fixity_audit_email(week_no).deliver_later

    #byebug
  end

end
