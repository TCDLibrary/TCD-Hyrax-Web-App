require 'rails_helper'

RSpec.describe 'ingests/show.html.erb', type: :view do

  before do
    @ingest = Ingest.new()
    render
  end

  it "draws the ingest detail" do
    expect(rendered).to have_content "Show Ingest"
    expect(rendered).to have_content "Object Model"
    expect(rendered).to have_content "XML File Name"
    expect(rendered).to have_content "New Work Type"
    expect(rendered).to have_content "Parent Type"

    expect(rendered).to have_content "Parent ID"
    expect(rendered).to have_content "Image Type"
    expect(rendered).to have_content "Submitted By"
    expect(rendered).to have_content "Created At"

  end
end
