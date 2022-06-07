class DoiToSierraMailer < ApplicationMailer
  default from: 'noreply@tcd.ie'

  def doi_to_sierra_email(max_rows_exceeded)
    @max_rows_exceeded = max_rows_exceeded
    mail(to: 'digcollsupport@tcd.ie', subject: 'Digital Collections - Sending DOI file to Sierra')
  end

end
