require 'spec_helper'

feature "An admin viewing other admins" do
  background do
    setup_admin_and_sign_in
  end

  scenario "An admin should be able to see a list of all admins" do
    admin = create(:admin)
    visit admin_admins_path
    expect(page).to have_content admin.name
  end

  scenario "An admin should be able to view an admin" do
    admin = create(:admin)
    visit admin_admin_path(admin)
    expect(page).to have_content admin.name
  end

  scenario "An admin should be able to create a new admin" do
    visit admin_admins_path
    click_link "Add new admin"
    fill_in :admin_email, with: Faker::Internet.email
    fill_in :admin_first_name, with: Faker::Name.first_name
    fill_in :admin_last_name, with: Faker::Name.last_name

    click_button "Create admin"

    expect(page).to have_content "Admin was created successfully"
  end
end
