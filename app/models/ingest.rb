class Ingest < ApplicationRecord

  scope :sorted, lambda { order("created_at DESC")}

end
