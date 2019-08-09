module Hyrax
  class FileSetEditForm < Hyrax::Forms::WorkForm
    include HydraEditor::Form
    include HydraEditor::Form::Permissions

    delegate :depositor, :permissions, to: :model

    self.required_fields = [:title, :creator, :keyword, :license]

    self.model_class = ::FileSet

    self.terms = [:resource_type, :title, :creator, :contributor, :description,
                  :keyword, :license, :publisher, :date_created, :subject, :language,
                  :identifier, :based_near, :related_url,
                  :visibility_during_embargo, :visibility_after_embargo, :embargo_release_date,
                  :visibility_during_lease, :visibility_after_lease, :lease_expiration_date,
                  :visibility, :camera_model, :camera_make, :date_taken, :exposure_time, :f_number,
                  :iso_speed_rating, :flash, :exposure_program, :focal_length, :software, :fedora_sha1]
  end
end
