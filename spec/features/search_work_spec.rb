require 'rails_helper'

RSpec.feature 'Search for a work' do
  let(:title) { ['Journey to Skull Island'] }
  let(:creator) { ['Quest, Jane'] }
  let(:keyword) { ['Pirates', 'Adventure'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let(:work) do
    Work.new(title: title,
             creator: creator,
             keyword: keyword,
             visibility: visibility)
  end

    context 'general search' do
      before do
        work.save
      end
      scenario "Search for a work" do
        visit("/")
        fill_in "q", with: "Journey"
        click_button "Go"
        # Uncomment this to display the HTML capybara is seeing
        # puts page.body
        expect(page).to have_content work.title.first
        expect(page).to have_content work.creator.first
        expect(page).to have_content work.abstract.first
        expect(page).to have_content work.keyword.first
        expect(page).to have_content work.dris_page_no.first
        #expect(page).to have_content work.copyright_status.first
        expect(page).to have_content work.genre.first
        expect(page).to have_content work.digital_object_identifier.first
        expect(page).to have_content work.dris_unique.first
        #expect(page).to have_content work.language_code.first
        #expect(page).to have_content work.role.first
        expect(page).to have_content work.sponsor.first
        expect(page).to have_content work.publisher_location.first
        expect(page).to have_content work.support.first
        expect(page).to have_content work.medium.first
        #expect(page).to have_content work.type_of_work.first
        #expect(page).to have_content work.subject_lcsh.first
        #expect(page).to have_content work.subject_local.first
        #expect(page).to have_content work.subject_name.first
        expect(page).to have_content work.alternative_title.first
        expect(page).to have_content work.series_title.first
        expect(page).to have_content work.collection_title.first

        expect(page).to have_content work.provenance.first
        expect(page).to have_content work.culture.first
        expect(page).to have_content work.folder_number.first
        expect(page).to have_content work.biographical_note.first
        expect(page).to have_content work.finding_aid.first
        expect(page).to have_content work.note.first
        expect(page).to have_content work.sub_fond.first
        expect(page).to have_content work.arrangement.first
        expect(page).to have_content work.issued_with.first

      end
    end
end
