When /^he fills in "([^"]*)" with "([^"]*)"$/ do |area, text|
  fill_in area, with: text
end

When /^he clicks (on )?"([^"]*)"$/ do |placeholder, text|
  click_on text
end

Then /^he should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^he sees "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^he should not see "([^"]*)"$/ do |text|
  page.should_not have_content(text)
end

# From https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Cucumber
# it says Warden/Devise redirects don't get recorded in the integration session properly 
# so you can't use assert_redirected_to. Use this instead:
Then /^I am redirected to "([^\"]*)"$/ do |url|
  assert [301, 302].include?(@integration_session.status), "Expected status to be 301 or 302, got #{@integration_session.status}"
  location = @integration_session.headers["Location"]
  assert_equal url, location
  visit location
end
