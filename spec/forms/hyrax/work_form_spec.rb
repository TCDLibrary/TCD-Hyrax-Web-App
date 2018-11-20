# Generated via
#  `rails generate hyrax:work Work`
require 'rails_helper'

RSpec.describe Hyrax::WorkForm do

  # 20-11-2018 JL:
  subject { form }
  let(:work)    { Work.new }
  let(:ability) { Ability.new(nil) }
  let(:request) { nil }
  let(:form)    { described_class.new(work, ability, request) }
  it "has the expected terms" do
    expect(form.terms).to include(:genre)
    expect(form.terms).to include(:bibliography)
    expect(form.terms).to include(:dris_page_no)
    expect(form.terms).to include(:dris_document_no)
    expect(form.terms).to include(:page_no)
    #expect(form.terms).to include(:page_type)
    expect(form.terms).to include(:catalog_no)
  end

end
