When /^he clicks on "([^"]*)"$/ do |text|
  click_on text
end

Then /^he sees "([^"]*)"$/ do |text|
  page.should have_content(text)
end

