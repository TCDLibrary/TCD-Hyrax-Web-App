# Generated via
#  `rails generate hyrax:work Work`

#  JL: 07/12/2018 : Added new metadata terms


require 'rails_helper'

RSpec.describe Hyrax::WorkPresenter do

  subject { presenter }

  let(:title) { ['Journey to Skull Island'] }
  let(:creator) { ['Quest, Jane'] }
  let(:keyword) { ['Pirates', 'Adventure'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let(:depositor) { 'test@example.com' }
  # JL: 07/12/2018:
  let(:dris_page_no) {['A Dris Page No']}
  #let(:copyright_status) {['A Copyright Holder']}
  let(:genre) {['A Genre']}
  let(:digital_object_identifier) {['A Digital Object Identifier']}
  let(:dris_unique) {['A Dris Unique']}
  #let(:language_code) {['A Language Code']}
  #let(:role) {['A Role']}
  let(:sponsor) {['A Sponsor']}
  let(:publisher_location) {['A Publisher Location']}
  let(:support) {['A Support']}
  let(:medium) {['A Medium']}
  #let(:type_of_work) {['A Type Of Work']}
  #let(:subject_lcsh) {['A Subject Lcsh']}
  #let(:subject_local) {['A Subject Local']}
  #let(:subject_name) {['A Subject Name']}
  let(:alternative_title) {['An Alternative Title']}
  let(:series_title) {['A Series Title']}
  let(:collection_title) {['A Collection Title']}

  let(:provenance) {['A Provenance']}
  let(:culture) {['A Culture']}

  let :work do
    Work.new(
      title: title,
      creator: creator,
      keyword: keyword,
      depositor: depositor,
      visibility: visibility,
      # JL : 07/12/2018
      dris_page_no: dris_page_no,
      #copyright_status: copyright_status,
      genre: genre,
      digital_object_identifier: digital_object_identifier,
      dris_unique: dris_unique,
      #language_code: language_code,
      #role: role,
      sponsor: sponsor,
      publisher_location: publisher_location,
      support: support,
      medium: medium,
      #type_of_work: type_of_work,
      #subject_lcsh: subject_lcsh,
      #subject_local: subject_local,
      #subject_name: subject_name,
      alternative_title: alternative_title,
      series_title: series_title,
      collection_title: collection_title,

      provenance: provenance,
      culture: culture
    )
  end

  let(:ability) { Ability.new(user) }

  let(:solr_document) { SolrDocument.new(work.to_solr) }

  let(:presenter) do
    described_class.new(solr_document, nil)
  end

  it "delegates genre to solr document" do
    expect(solr_document).to receive(:genre)
    presenter.genre
  end

  # JL: 2020-04-27 suppress Page No
  #it "delegates dris_page_no to solr document" do
  #  expect(solr_document).to receive(:dris_page_no)
  #  presenter.dris_page_no
  #end

  #it "delegates copyright_status to solr document" do
  #  expect(solr_document).to receive(:copyright_status)
  #  presenter.copyright_status
  #end

  it "delegates digital_object_identifier to solr document" do
    expect(solr_document).to receive(:digital_object_identifier)
    presenter.digital_object_identifier
  end

  it "delegates dris_unique to solr document" do
    expect(solr_document).to receive(:dris_unique)
    presenter.dris_unique
  end

  #it "delegates language_code to solr document" do
  #  expect(solr_document).to receive(:language_code)
  #  presenter.language_code
  #end

  #it "delegates role to solr document" do
  #  expect(solr_document).to receive(:role)
  #  presenter.role
  #end

  it "delegates sponsor to solr document" do
    expect(solr_document).to receive(:sponsor)
    presenter.sponsor
  end

  it "delegates publisher_location to solr document" do
    expect(solr_document).to receive(:publisher_location)
    presenter.publisher_location
  end

  it "delegates support to solr document" do
    expect(solr_document).to receive(:support)
    presenter.support
  end

  it "delegates medium to solr document" do
    expect(solr_document).to receive(:medium)
    presenter.medium
  end

  #it "delegates type_of_work to solr document" do
  #  expect(solr_document).to receive(:type_of_work)
  #  presenter.type_of_work
  #end

  #it "delegates subject_lcsh to solr document" do
  #  expect(solr_document).to receive(:subject_lcsh)
  #  presenter.subject_lcsh
  #end

  #it "delegates subject_local to solr document" do
  #  expect(solr_document).to receive(:subject_local)
  #  presenter.subject_local
  #end

  #it "delegates subject_name to solr document" do
  #  expect(solr_document).to receive(:subject_name)
  #  presenter.subject_name
  #end

  it "delegates alternative_title to solr document" do
    expect(solr_document).to receive(:alternative_title)
    presenter.alternative_title
  end

  it "delegates series_title to solr document" do
    expect(solr_document).to receive(:series_title)
    presenter.series_title
  end

  it "delegates collection_title to solr document" do
    expect(solr_document).to receive(:collection_title)
    presenter.collection_title
  end

  it "delegates provenance to solr document" do
    expect(solr_document).to receive(:provenance)
    presenter.provenance
  end

  it "delegates culture to solr document" do
    expect(solr_document).to receive(:culture)
    presenter.culture
  end

end
