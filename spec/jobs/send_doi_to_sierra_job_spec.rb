require 'rails_helper'

RSpec.describe SendDoiToSierraJob, type: :job do
  describe "call DOI to Sierra export" do
    context "with an empty db" do
      it "writes MarcXML file" do
        result = SendDoiToSierraJob.perform_now
        output = Rails.application.config.export_folder  + "DOIs_To_Sierra.xml"
        #byebug
        expect(File).to exist(output)
      end
    end
 end
end
