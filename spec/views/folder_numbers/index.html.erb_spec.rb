require 'rails_helper'

RSpec.describe "folder_numbers/index.html.erb", type: :view do

  before do
    render
  end

  it "draws the folder_number index view" do
    expect(rendered).to have_content "Add New Folder Number/Project ID"
    expect(rendered).to have_content "Folder Number/Project ID"
    expect(rendered).to have_content "Root Filename"
    expect(rendered).to have_content "Title"
    expect(rendered).to have_content "Job Type"
    expect(rendered).to have_content "Actions"
  end

end
