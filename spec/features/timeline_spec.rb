require 'rails_helper'
require 'sign_up_helper'

RSpec.feature "Timeline", type: :feature do
  scenario "Can submit posts and view them" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "Hello, world!"
    click_button "Cast it!"
    expect(page).to have_content("Hello, world!")
  end

  scenario "Can see date and time posts submitted" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "Hello, world!"
    click_button "Cast it!"
    created_at = Post.all[0].created_at.strftime('%H:%M, %-d %B')
    expect(page).to have_content(created_at)
  end

  scenario "Can see posts in reverse chronological order" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "Hello, world!"
    click_button "Cast it!"
    click_link "New post"
    fill_in "Add your new message", with: "Hello, world again!"
    click_button "Cast it!"
    expect("Hello, world again!").to appear_before "Hello, world!"
  end

  scenario "Can submit post with line breaks" do
    create_user_and_sign_up
    visit "/posts"
    click_link "New post"
    fill_in "Add your new message", with: "New\nline breaks\nin this message"
    click_button "Cast it!"
    expect(page.body).to include("New\n<br />line breaks\n<br />in this message")
  end
end
