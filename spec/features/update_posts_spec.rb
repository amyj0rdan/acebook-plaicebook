require 'rails_helper'
require 'sign_up_helper'

RSpec.feature "Update posts", type: :feature do
  scenario "user can update an existing post" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "This message is going to be updated!"
    click_button "Cast it!"
    click_link "Update"
    fill_in "Update your message", with: "This message has been updated!"
    click_button "Cast it again!"
    expect(page).to have_content "This message has been updated!"
  end

  scenario "user cannot update other user's post" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "User 1 message"
    click_button "Cast it!"
    click_button "Sign out"
    create_second_user_and_sign_in
    expect(page).to have_no_link "Update"
  end

  scenario "user cannot update an existing post after 10 minutes" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "This message is not going to be updated!"
    click_button "Cast it!"
    Timecop.travel(Time.now + 11.minutes) do
      visit "/posts"
      expect(page).to have_no_link "Update"
    end
  end
end
