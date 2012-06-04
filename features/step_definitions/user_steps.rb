Given /^"([^"]*)" is an event planner$/ do |event_planner_name|
  @user = FactoryGirl.create(:user, username: event_planner_name)
end

Given /^"([^"]*)" is logged in as an event planner$/ do |event_planner_name|
  @user = FactoryGirl.create(:user, username: event_planner_name)
  visit '/users/sign_in'
  fill_in "user_login", with: event_planner_name
  fill_in "user_password", with: "abc123"
  click_button "Sign in"
  page.should have_content("Signed in successfully."), "Should have seen the flash for signing in successfully."
end

Given /^he is not logged in$/ do
  visit(destroy_user_session_path) # make sure not logged in
end

Given /^he is on his dashboard page$/ do
  visit events_path
end

When /^he fills out the new user form$/ do
  within("#new_user") do
    fill_in "Username", :with => "gw"
    fill_in "Email", :with => "gw@example.com"
    fill_in "Password", :with => "abc123"
    fill_in "Password confirmation", :with => "abc123"
    click_button "Sign up"
  end
end

When /^he submits the sign up form$/ do
  within("form#new_user") do
    click_on "Sign up"
  end
end
