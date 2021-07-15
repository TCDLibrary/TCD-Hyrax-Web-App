#  JL: Created on 07/12/2018

require 'rails_helper'

RSpec.feature 'Display a Work' do
  let(:title)      { ['Journey to Skull Island'] }
  let(:creator)    { ['Quest, Jane'] }
  let(:keyword)    { ['Pirates', 'Adventure'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let(:user)       { 'test@example.com' }
  let(:dris_page_no)                {['A Dris Page No']}
  #let(:copyright_status)            {['A Copyright Status']}
  let(:genre)                       {['A Genre']}
  let(:digital_object_identifier)   {['A Digital Object Identifier']}
  let(:dris_unique)                 {['A Dris Unique']}
  #let(:language_code)               {['A Language Code']}
  #let(:role)                        {['A Role']}
  let(:sponsor)                     {['A Sponsor']}
  let(:publisher_location)          {['A Publisher Location']}
  let(:support)                     {['A Support']}
  let(:medium)                      {['A Medium']}
  #let(:type_of_work)                {['A Type Of Work']}
  #let(:subject_lcsh)                {['A Subject Lcsh']}
  #let(:subject_local)               {['A Subject Local']}
  #let(:subject_name)                {['A Subject Name']}
  let(:alternative_title)           {['An Alternative Title']}
  let(:series_title)                {['A Series Title']}
  let(:collection_title)            {['A Collection Title']}

  let(:provenance)                  {['A Provenance']}
  let(:culture)                     {['A Culture']}
  let(:folder_number)               {['123']}
  let(:biographical_note)           {['A Biographical Note']}
  let(:finding_aid)                 {['Finding Aid']}
  let(:note)                        {['A Note']}

  #let()

  let :work do
    Work.create(title:                      title,
                creator:                    creator,
                keyword:                    keyword,
                visibility:                 visibility,
                depositor:                  user,
                dris_page_no:               dris_page_no,
                #copyright_status:           copyright_status,
                genre:                      genre,
                digital_object_identifier:  digital_object_identifier,
                dris_unique:                dris_unique,
                #language_code:              language_code,
                #role:                       role,
                sponsor:                    sponsor,
                publisher_location:         publisher_location,
                support:                    support,
                medium:                     medium,
                #type_of_work:               type_of_work,
                #subject_lcsh:               subject_lcsh,
                #subject_local:              subject_local,
                #subject_name:               subject_name,
                alternative_title:          alternative_title,
                series_title:               series_title,
                collection_title:           collection_title,
                provenance:                 provenance,
                culture:                    culture,
                folder_number:              folder_number,
                biographical_note:          biographical_note,
                finding_aid:                finding_aid,
                note:                       note
              )
  end

  scenario "Show a public Work" do
    visit("/concern/works/#{work.id}")

    expect(page).to have_content work.title.first
    expect(page).to have_content work.creator.first
    expect(page).to have_content work.keyword.first
    expect(page).to have_content work.keyword.last
    # JL: 2020-04-27 suppress Page No
    #expect(page).to have_content work.dris_page_no.first
    #expect(page).to have_content work.copyright_status.first
    expect(page).to have_content work.genre.first
    expect(page).to have_content work.digital_object_identifier.first
    # JL: 06/02/2019 dris_unique is ingested but not displayed
    #expect(page).to have_content work.dris_unique.first
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
    expect(page).to have_content work.biographical_note.first
    expect(page).to have_content work.finding_aid.first
    expect(page).to have_content work.note.first
    # you have to be logged in to see folder_number
    # expect(page).to have_content work.folder_number.first
  end
end
