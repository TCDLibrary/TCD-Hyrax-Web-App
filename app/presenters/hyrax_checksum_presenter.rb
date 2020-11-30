class HyraxChecksumPresenter

  def audited
    HyraxChecksum.where(:last_fixity_result => ["PASS", "FAIL"]).count
  end

  def failed
    HyraxChecksum.where(:last_fixity_result => "FAIL").count
  end

end
