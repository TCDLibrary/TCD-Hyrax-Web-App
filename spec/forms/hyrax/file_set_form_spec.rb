# Generated via
#  `rails generate hyrax:work Folio`
require 'rails_helper'

RSpec.describe Hyrax::FileSetEditForm do
  # 13-12-2018 JL:
  subject { form }
  let(:fs)    { FileSet.new }
  let(:ability) { Ability.new(nil) }
  let(:request) { nil }
  let(:form)    { described_class.new(fs, ability, request) }
  it "has the expected terms" do
    expect(form.terms).to include(:camera_model)
    expect(form.terms).to include(:camera_make)
    expect(form.terms).to include(:date_taken)
    expect(form.terms).to include(:exposure_time)
    expect(form.terms).to include(:f_number)
    expect(form.terms).to include(:iso_speed_rating)
    expect(form.terms).to include(:flash)
    expect(form.terms).to include(:exposure_program)
    expect(form.terms).to include(:focal_length)
    expect(form.terms).to include(:software)
  end

end
