Given /^a non\-logged\-in user$/ do
  puts "When we have sessions, this step should clear them."
end

Given /^"([^"]*)" is an event planner$/ do |event_planner_name|
  # this is probably wrong, event planner might not be a separate model
  pass
  #@user = Factory(:event_planner, name: event_planner_name)
end

Given /^he is logged in$/ do
  pass
  #log_in(@user)
end

Given /^he is on his dashboard page$/ do
  visit dashboard_path
end

When /^he goes to the home page$/ do
  visit root_path
end

When /^he registers with name "([^"]*)" and email "([^"]*)"$/ do |name, email|
  fill_in "Name", with: name
  fill_in "Email", with: email
  fill_in "Password", with: "passsword"
  fill_in "Password confirmation", with: "passsword"
  click_button "Register"
end

Then /^he fills in email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  fill_in "auth_key", with: email
  fill_in "password", with: password
  click_button "Login"
end

Given /^there is a local user with email "([^"]*)"$/ do |email|
  FactoryGirl.create(:local_user, email: email)
end

Given /^he is not logged in$/ do
  # session[:user_id] = nil
end
