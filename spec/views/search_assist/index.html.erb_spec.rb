require 'rails_helper'

RSpec.describe "search_assist/index.html.erb", type: :view do

  before do
    render
  end

  it "draws the ingests" do
    expect(rendered).to have_content "Search Tips"
    expect(rendered).to have_content "Refining Your Search:"

  end

end
