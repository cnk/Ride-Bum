When /^he fills in "([^"]*)" with "([^"]*)"$/ do |area, text|
  fill_in area, with: text
end

When /^he clicks (on )?"([^"]*)"$/ do |placeholder, text|
  click_on text
end

Then /^he sees "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^he should not see "([^"]*)"$/ do |text|
  page.should_not have_content(text)
end
