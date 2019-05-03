def create_post
  visit "/posts"
  click_link "New post"
  fill_in "Add your new message", with: "Test message!"
  click_button "Cast it!"
end
