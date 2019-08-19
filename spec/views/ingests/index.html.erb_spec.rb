require 'rails_helper'

RSpec.describe 'ingests/index.html.erb', type: :view do

  before do
    render
  end

  it "draws the ingests" do
    expect(rendered).to have_content "Ingests"
    expect(rendered).to have_content "Add New Ingest"
    expect(rendered).to have_content "XML File Name"
    expect(rendered).to have_content "Submitted By"
    expect(rendered).to have_content "Submitted At"

  end
end
