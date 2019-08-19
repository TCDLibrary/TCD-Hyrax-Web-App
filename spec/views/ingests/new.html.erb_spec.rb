require 'rails_helper'

RSpec.describe 'ingests/new.html.erb', type: :view do
  before do
    @ingest = Ingest.new()
    render
  end

  it "draws the form" do
    expect(rendered).to have_content "Ingest Object Model Type"
    expect(rendered).to have_field("ingest[object_model_type]", with: 'Multiple Objects, One Image Each')

    expect(rendered).to have_content "Files available to ingest:"

    expect(rendered).to have_content "I want to import:"
    expect(rendered).to have_field "ingest_new_work_type_folios"

    expect(rendered).to have_content "Object Hierarchy:"
    expect(rendered).to have_field "ingest_parent_type_collection"

    expect(rendered).to have_content "Optional parent id:"

    expect(rendered).to have_content "Attach images?"
    expect(rendered).to have_field("ingest[image_type]", with: 'LO')

  end
end
