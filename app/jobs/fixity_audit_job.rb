class FixityAuditJob < ApplicationJob
  queue_as :fixity

  def perform(*args)
    # Do something later:

    # What week number is this?

    # Read fixity table for week Number

    # Loop
    #    > call FixityCheckJob
    #    > wait for the results? run it now?
    #    > Update the fixity audit table
    # end loop

    # send email
    FixityAuditMailer.fixity_audit_email.deliver_later

    #byebug
  end
end
