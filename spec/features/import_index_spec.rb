require 'rails_helper'
include Warden::Test::Helpers

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

#RSpec.feature ImportController, type: :controller do
RSpec.feature 'Import Work', js: true do

  context 'a logged in user' do
    Capybara.javascript_driver = :selenium_chrome_headless
    let(:user_attributes) do
      { email: 'test@example.com' }
      # { email: ::User.batch_user.email }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end
    let(:admin_set_id) { AdminSet.find_or_create_default_admin_set_id }
    let(:permission_template) { Hyrax::PermissionTemplate.find_or_create_by!(source_id: admin_set_id) }
    let(:workflow) { Sipity::Workflow.create!(active: true, name: 'test-workflow', permission_template: permission_template) }

    before do
      # Create a single action that can be taken
      Sipity::WorkflowAction.create!(name: 'submit', workflow: workflow)

      admin = Role.create(name: "admin")
      admin.users << user
      admin.save
      
      # Grant the user access to deposit into the admin set.
      Hyrax::PermissionTemplateAccess.create!(
        permission_template_id: permission_template.id,
        agent_type: 'user',
        agent_id: user.user_key,
        access: 'deposit'
      )
      #byebug
      login_as user
    end

    #describe "GET #index" do
    #  it "returns http success" do
    #    get :index
    #    expect(response).to have_http_status(:success)
    #  end
    #end
    scenario do
      visit '/import/index'
      expect(page).to have_content "Ingest"
    end

  end



end
