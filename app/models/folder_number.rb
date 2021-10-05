class FolderNumber < ApplicationRecord
  scope :sorted, lambda {order("project_id DESC")}

  validates :root_filename, presence: { message: ': You must provide a root filename.' }
  validates :title, presence: { message: ': You must provide a title.' }
  validates :job_type, presence: { message: ': You must provide a job title.' }
  validates :status, presence: { message: ': You must provide a status.' }

end
