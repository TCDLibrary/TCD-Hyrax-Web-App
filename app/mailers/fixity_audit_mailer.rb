class FixityAuditMailer < ApplicationMailer
  default from: 'noreply@tcd.ie'

  def fixity_audit_email
    #@user = params[:user]
    #@url  = 'http://example.com/login'
    #byebug
    mail(to: 'jlakes@tcd.ie', subject: 'Digital Collections Fixity Audit')
  end
end
