# Generated via
#  `rails generate hyrax:work Work`
require 'rails_helper'
include Warden::Test::Helpers

# NOTE: If you generated more than one work, you have to set "js: true"
RSpec.feature 'Create a Collection', js: true do
  context 'a logged in user' do
    Capybara.javascript_driver = :selenium_chrome_headless
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    default = Hyrax::CollectionType.find_or_create_default_collection_type
    if Hyrax::CollectionType.exists?(machine_id: default.machine_id)
      puts "Default collection type is #{default.machine_id}"
    else
      warn "ERROR: A default collection type did not get created."
    end

    let(:admin_set_id) { AdminSet.find_or_create_default_admin_set_id }
    let(:permission_template) { Hyrax::PermissionTemplate.find_or_create_by!(source_id: admin_set_id) }
    let(:workflow) { Sipity::Workflow.create!(active: true, name: 'test-workflow', permission_template: permission_template) }

    before do
      # Create a single action that can be taken
      Sipity::WorkflowAction.create!(name: 'submit', workflow: workflow)

      # Grant the user access to deposit into the admin set.
      Hyrax::PermissionTemplateAccess.create!(
        permission_template_id: permission_template.id,
        agent_type: 'user',
        agent_id: user.user_key,
        access: 'manage'
      )
      login_as user
    end

    scenario do
      visit '/dashboard'
      click_link "Collections"
      click_link "New Collection"

      # If you generate more than one work uncomment these lines
      # choose "payload_concern", option: "User Collection"
      # click_button "Create collection"

      expect(page).to have_content "New User Collection"
      fill_in('Title', with: 'My Test Collection')
      fill_in('Abstract or Summary', with: 'My Abstract or Summary')

      # Hyrax standard fields:
      # 20-11-2018 JL:
      click_link("Additional fields")

      fill_in('Creator', with: 'A Creator')
      fill_in('Contributor', with: 'A Contributor')
      fill_in('Keyword', with: 'A Keyword')
      # Licence', with: '')
      ### : dropdown, e.g."Creative Commons Public Domain Mark 1.0"
      fill_in('Publisher', with: 'A Publisher')
      fill_in('Date Created', with: 'A Date Created')
      fill_in('Subject', with: 'A Subject')
      fill_in('Language', with: 'A Language')
      fill_in('Identifier', with: 'An Identifier')
      fill_in('Related URL', with: 'A Related URL')
      # Resource type', with: '')
      ### : list, e.g. "Book"
      #fill_in('Genre', with: 'A Genre')


      # 20-11-2018 JL:
      # require tcd_metadata.rb
      #click_link("Additional fields")
      #fill_in "Creator", with: "A Creator"

      # With selenium and the chrome driver, focus remains on the
      # select box. Click outside the box so the next line can't find
      # its element
      #find('body').click
      #choose('work_visibility_open')

      click_on('Save')
      expect(page).to have_content('My Test Collection')

      #expect(page).to have_content('A Creator')
      #expect(page).to have_content('A Contributor')
      #expect(page).to have_content('A Keyword')
      #expect(page).to have_content('A Publisher')
      #expect(page).to have_content('A Date Created')
      #expect(page).to have_content('A Subject')
      #expect(page).to have_content('A Language')
      #expect(page).to have_content('An Identifier')
      #expect(page).to have_content('A Related URL')


    end
  end
end
