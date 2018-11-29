# Generated via
#  `rails generate hyrax:work Work`
require 'rails_helper'

RSpec.describe Hyrax::WorkForm do

  # 20-11-2018 JL:
  subject { form }
  let(:work)    { Work.new }
  let(:ability) { Ability.new(nil) }
  let(:request) { nil }
  let(:form)    { described_class.new(work, ability, request) }
  it "has the expected terms" do
    expect(form.terms).to include(:genre)
    expect(form.terms).to include(:bibliography)
    expect(form.terms).to include(:dris_page_no)
    expect(form.terms).to include(:dris_document_no)
    expect(form.terms).to include(:dris_unique)
    expect(form.terms).to include(:format_duration)
    expect(form.terms).to include(:format_resolution)
    expect(form.terms).to include(:copyright_holder)
    expect(form.terms).to include(:digital_root_number)
    expect(form.terms).to include(:digital_object_identifier)
    expect(form.terms).to include(:language_code)
    expect(form.terms).to include(:location_type)
    expect(form.terms).to include(:shelf_locator)
    expect(form.terms).to include(:role)
    expect(form.terms).to include(:role_code)
    expect(form.terms).to include(:sponsor)
    expect(form.terms).to include(:conservation_history)
    expect(form.terms).to include(:publisher_location)
    expect(form.terms).to include(:page_number)
    expect(form.terms).to include(:page_type)
    expect(form.terms).to include(:physical_extent)
  end

end
