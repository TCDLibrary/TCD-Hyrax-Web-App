require 'rails_helper'

RSpec.describe Hyrax::Forms::CollectionForm do
  # 20-11-2018 JL:
  subject { form }
  let(:coll)    { Collection.new }
  let(:ability) { Ability.new(nil) }
  let(:request) { nil }
  let(:form)    { described_class.new(coll, ability, request) }
  it "has the expected terms" do
    #byebug
    expect(form.terms).to include(:creator)
    expect(form.terms).to include(:contributor)
    expect(form.terms).to include(:keyword)
    expect(form.terms).to include(:publisher)
    expect(form.terms).to include(:date_created)
    expect(form.terms).to include(:subject)
    expect(form.terms).to include(:language)
    expect(form.terms).to include(:identifier)
    expect(form.terms).to include(:related_url)

    # 13/12/2018 JL: Extra metadata terms for TCD
    # expect(form.terms).to include(:genre)
    # expect(form.terms).to include(:bibliography)
    # expect(form.terms).to include(:dris_page_no)
    # expect(form.terms).to include(:dris_document_no)
    # expect(form.terms).to include(:dris_unique)
    # expect(form.terms).to include(:format_duration)

    # expect(form.terms).to include(:copyright_status)
    # expect(form.terms).to include(:copyright_note)
    # expect(form.terms).to include(:digital_root_number)
    # expect(form.terms).to include(:digital_object_identifier)
    # expect(form.terms).to include(:language_code)
    # expect(form.terms).to include(:location_type)
    # expect(form.terms).to include(:shelf_locator)
    # expect(form.terms).to include(:role)
    # expect(form.terms).to include(:role_code)
    # expect(form.terms).to include(:sponsor)
    # expect(form.terms).to include(:conservation_history)
    # expect(form.terms).to include(:publisher_location)
    # expect(form.terms).to include(:page_number)
    # expect(form.terms).to include(:page_type)
    # expect(form.terms).to include(:physical_extent)
    # expect(form.terms).to include(:support)
    # expect(form.terms).to include(:medium)
    # expect(form.terms).to include(:type_of_work)

    # expect(form.terms).to include(:subject_lcsh)
    # expect(form.terms).to include(:subject_local)
    # expect(form.terms).to include(:subject_name)
    # expect(form.terms).to include(:alternative_title)
    # expect(form.terms).to include(:series_title)

    # expect(form.terms).to include(:provenance)
    # expect(form.terms).to include(:culture)
    # expect(form.terms).to include(:county)
    # expect(form.terms).to include(:folder_number)
    # expect(form.terms).to include(:project_number)
    # expect(form.terms).to include(:order_no)
    # expect(form.terms).to include(:total_records)

  end

end
