class FolderNumber < ApplicationRecord
  scope :sorted, lambda {order("project_id DESC")}
end
