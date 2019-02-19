require 'rails_helper'

RSpec.describe ExportController, type: :controller do

  describe "GET #dublinCore with no ID" do
    it "returns http success" do

      url = "dublinCore?ID=000000000"

      #get url
      @request.env['HTTP_ACCEPT'] = 'application/xml'
      get "dublinCore", :params => { :id => "000000000" }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #dublinCore with Folio ID" do
    it "returns xml data" do

      folio = Folio.new
      folio.id = '123456789'
      folio.title << 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
      folio.creator << 'A Creator'
      folio.subject << 'A Subject'
      folio.description << 'A Description'
      folio.publisher << 'A Publisher'
      folio.contributor << 'A Contributor'
      folio.date_created << '1970-01-01'
      folio.date_uploaded = '2019-01-01'
      folio.date_modified = '2019-02-01'
      folio.resource_type << 'A Resource Type'
      folio.identifier << 'An Identifier'
      folio.language << 'A Language'
      folio.copyright_status << 'A Copyright Status'
      folio.bibliographic_citation << 'A Bibliography'

      folio.save

      #byebug
      #get url
      @request.env['HTTP_ACCEPT'] = 'application/xml'
      get "dublinCore", :params => { :id => folio.id }
      expect(response).to have_http_status(:success)
      # TODO: The response doesn't contain my title. How to test?
      # expect(response.title).to eq(["An Abstract"])
    end
  end


end
