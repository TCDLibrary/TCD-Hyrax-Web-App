require 'rails_helper'

RSpec.feature 'Display Search Tips' do

  scenario "Display Search Tips" do
    visit("/search_tips")

    expect(page).to have_http_status(:success)

  end
end
