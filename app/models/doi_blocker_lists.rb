class DoiBlockerLists < ApplicationRecord
    scope :sorted, lambda { order("object_id ASC")}
end
  
