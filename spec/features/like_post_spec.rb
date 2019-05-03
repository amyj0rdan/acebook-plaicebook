require 'rails_helper'
require 'sign_up_helper'

RSpec.feature "Like posts", type: :feature do
  scenario "User can like a post" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "Test message!"
    click_button "Cast it!"
    click_on(class: 'like-post-button')
    expect(page).to have_css(".post-number-of-likes", text: "1")
  end

  scenario "User can unlike a post they previously liked" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "Test message!"
    click_button "Cast it!"
    click_on(class: 'like-post-button')
    click_on(class: 'unlike-post-button')
    expect(page).to have_css(".post-number-of-likes", text: "0")
  end
end
