require 'rails_helper'

RSpec.describe "image_display_names/new.html.erb", type: :view do

  before do
    render
  end

  it "draws the image_display_names new view" do
    expect(rendered).to have_content "Object Id: Paste excel data here:"
    expect(rendered).to have_button('Generate Table')
  end

end
