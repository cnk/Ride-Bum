Given /^"([^"]*)" is an event planner$/ do |event_planner_name|
  @user = Factory(:user, username: event_planner_name)
end

Given /^"([^"]*)" is logged in as an event planner$/ do |event_planner_name|
  @user = Factory(:user, username: event_planner_name)
  visit '/users/sign_in'
  fill_in "user_login", :with=>@user.login
  fill_in "user_password", :with=>"password"
  click_button "Sign in"
end

Given /^he is not logged in$/ do
  visit(destroy_user_session_path) # make sure not logged in
end

Given /^he is on his dashboard page$/ do
  visit dashboard_path
end

When /^he fills out the new user form$/ do
  steps %Q{And he fills in "Username" with "gw"
  And he fills in "Email" with "gw@example.com"
  And he fills in "Password" with "password"
  And he fills in "Password confirmation" with "password"
  And he submits the sign up form}
end

When /^he submits the sign up form$/ do
  within("form#new_user") do
    click_on "Sign up"
  end
end
