#  JL: Created on 07/12/2018

require 'rails_helper'

RSpec.feature 'Display a Work' do
  let(:title)      { ['Journey to Skull Island'] }
  let(:creator)    { ['Quest, Jane'] }
  let(:keyword)    { ['Pirates', 'Adventure'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let(:user)       { 'test@example.com' }
  let(:dris_page_no)                {['A Dris Page No']}
  let(:copyright_holder)            {['A Copyright Holder']}
  let(:genre)                       {['A Genre']}
  let(:digital_object_identifier)   {['A Digital Object Identifier']}
  let(:dris_unique)                 {['A Dris Unique']}
  let(:language_code)               {['A Language Code']}
  let(:role)                        {['A Role']}
  let(:sponsor)                     {['A Sponsor']}
  let(:publisher_location)          {['A Publisher Location']}
  let(:support)                     {['A Support']}
  let(:medium)                      {['A Medium']}
  let(:type_of_work)                {['A Type Of Work']}
  let(:subject_lcsh)                {['A Subject Lcsh']}
  let(:subject_local)               {['A Subject Local']}
  let(:subject_name)                {['A Subject Name']}
  let(:alternative_title)           {['An Alternative Title']}
  let(:series_title)                {['A Series Title']}
  let(:collection_title)            {['A Collection Title']}
  let(:virtual_collection_title)    {['A Virtual Collection Title']}
  let(:provenance)                  {['A Provenance']}
  let(:culture)                     {['A Culture']}


  #let()

  let :work do
    Work.create(title:                      title,
                creator:                    creator,
                keyword:                    keyword,
                visibility:                 visibility,
                depositor:                  user,
                dris_page_no:               dris_page_no,
                copyright_holder:           copyright_holder,
                genre:                      genre,
                digital_object_identifier:  digital_object_identifier,
                dris_unique:                dris_unique,
                language_code:              language_code,
                role:                       role,
                sponsor:                    sponsor,
                publisher_location:         publisher_location,
                support:                    support,
                medium:                     medium,
                type_of_work:               type_of_work,
                subject_lcsh:               subject_lcsh,
                subject_local:              subject_local,
                subject_name:               subject_name,
                alternative_title:          alternative_title,
                series_title:               series_title,
                collection_title:           collection_title,
                virtual_collection_title:   virtual_collection_title,
                provenance:                 provenance,
                culture:                    culture
              )
  end

  scenario "Show a public Work" do
    visit("/concern/works/#{work.id}")

    expect(page).to have_content work.title.first
    expect(page).to have_content work.creator.first
    expect(page).to have_content work.keyword.first
    expect(page).to have_content work.keyword.last
    expect(page).to have_content work.dris_page_no.first
    expect(page).to have_content work.copyright_holder.first
    expect(page).to have_content work.genre.first
    expect(page).to have_content work.digital_object_identifier.first
    expect(page).to have_content work.dris_unique.first
    expect(page).to have_content work.language_code.first
    expect(page).to have_content work.role.first
    expect(page).to have_content work.sponsor.first
    expect(page).to have_content work.publisher_location.first
    expect(page).to have_content work.support.first
    expect(page).to have_content work.medium.first
    expect(page).to have_content work.type_of_work.first
    expect(page).to have_content work.subject_lcsh.first
    expect(page).to have_content work.subject_local.first
    expect(page).to have_content work.subject_name.first
    expect(page).to have_content work.alternative_title.first
    expect(page).to have_content work.series_title.first
    expect(page).to have_content work.collection_title.first
    expect(page).to have_content work.virtual_collection_title.first
    expect(page).to have_content work.provenance.first
    expect(page).to have_content work.culture.first                       
  end
end
