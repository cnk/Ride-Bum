When /^a person goes to the home page$/ do
  visit root_path
end

Then /^he sees information about Ride Bum$/ do
  information = "Welcome to Ride Bum"
  page.should  have_content(information)
end
