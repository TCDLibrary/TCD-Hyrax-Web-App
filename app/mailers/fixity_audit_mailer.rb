class FixityAuditMailer < ApplicationMailer
  default from: 'noreply@tcd.ie'

  def fixity_audit_email(week_no)
    @week_no = week_no
    mail(to: 'digcollsupport@tcd.ie', subject: 'Digital Collections Fixity Audit')
  end
end
