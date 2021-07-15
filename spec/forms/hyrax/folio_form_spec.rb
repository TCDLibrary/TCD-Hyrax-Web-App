# Generated via
#  `rails generate hyrax:work Folio`
require 'rails_helper'

RSpec.describe Hyrax::FolioForm do
  # 13-12-2018 JL:
  subject { form }
  let(:folio)    { Folio.new }
  let(:ability) { Ability.new(nil) }
  let(:request) { nil }
  let(:form)    { described_class.new(folio, ability, request) }
  it "has the expected terms" do
    expect(form.terms).to include(:abstract)
    expect(form.terms).to include(:genre)
    expect(form.terms).to include(:bibliography)
    expect(form.terms).to include(:dris_page_no)
    expect(form.terms).to include(:dris_document_no)
    expect(form.terms).to include(:dris_unique)
    expect(form.terms).to include(:format_duration)

    expect(form.terms).to include(:copyright_status)
    expect(form.terms).to include(:copyright_note)
    expect(form.terms).to include(:digital_root_number)
    expect(form.terms).to include(:digital_object_identifier)
    #expect(form.terms).to include(:language_code)
    expect(form.terms).to include(:location_type)
    expect(form.terms).to include(:shelf_locator)
    #expect(form.terms).to include(:role)
    #expect(form.terms).to include(:role_code)
    expect(form.terms).to include(:sponsor)
    expect(form.terms).to include(:conservation_history)
    expect(form.terms).to include(:publisher_location)
    expect(form.terms).to include(:page_number)
    expect(form.terms).to include(:page_type)
    expect(form.terms).to include(:physical_extent)
    expect(form.terms).to include(:support)
    expect(form.terms).to include(:medium)
    #expect(form.terms).to include(:type_of_work)

    #expect(form.terms).to include(:subject_lcsh)
    #expect(form.terms).to include(:subject_local)
    #expect(form.terms).to include(:subject_name)
    expect(form.terms).to include(:alternative_title)
    expect(form.terms).to include(:series_title)
    expect(form.terms).to include(:collection_title)

    expect(form.terms).to include(:provenance)
    expect(form.terms).to include(:culture)
    expect(form.terms).to include(:county)
    expect(form.terms).to include(:folder_number)
    expect(form.terms).to include(:project_number)
    expect(form.terms).to include(:order_no)
    expect(form.terms).to include(:total_records)
    expect(form.terms).to include(:location)
    expect(form.terms).to include(:biographical_note)
    expect(form.terms).to include(:finding_aid)
    expect(form.terms).to include(:note)

  end

end
