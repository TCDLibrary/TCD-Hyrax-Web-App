class HyraxChecksum < ApplicationRecord
  scope :sorted, lambda { order("ingest_date DESC")}
  scope :audited, lambda { where("last_fixty_result = 'PASS'") }
  #scope :not_admin, where(:last_fixty_result =>  "PASS")
#  scope :whiners, { select("*").where("last_fixty_result NE 'PASS'") }
end
