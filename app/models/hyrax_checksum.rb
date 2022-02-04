class HyraxChecksum < ApplicationRecord
  scope :sorted, lambda { where("last_fixity_result = 'fail' AND deleted_by is NULL").order("ingest_date DESC")}
  scope :audited, lambda { where("last_fixty_result IN ['pass','fail'] AND deleted_by is NULL") }
  scope :failed, lambda { where("last_fixty_result IN ['fail'] AND deleted_by is NULL") }
  scope :weekly, ->(week_no) { where("ingest_week_no = ?", week_no).where("DATEDIFF(CURDATE(), ingest_date) > 180 AND deleted_by is NULL") }
  #scope :not_admin, where(:last_fixty_result =>  "PASS")
#  scope :whiners, { select("*").where("last_fixty_result NE 'PASS'") }
  self.primary_key = 'fileset_id'
end
