require 'rails_helper'
require 'sign_up_helper'

RSpec.feature "Delete posts", type: :feature do
  scenario "user can delete an existing post" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "This message is going to be deleted!"
    click_button "Cast it!"
    click_button "Delete"
    expect(page).not_to have_content "This message is going to be deleted!"
  end

  scenario "user cannot delete other user's post" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "User 1 message"
    click_button "Cast it!"
    click_button "Sign out"
    create_second_user_and_sign_in
    expect(page).to have_no_button "Delete"
  end

  scenario "user sees success message on deleting a post" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "This message is going to be deleted!"
    click_button "Cast it!"
    click_button "Delete"
    expect(page).to have_content "Thank cod that's gone!"
  end
end
