When /^he enters (\d+) for the number of free seats in his car$/ do |seats|
  fill_in "Available seats", with: seats
  click_on("Create Ride")
end

Then /^he should see his car on the list of rides$/ do
  page.should have_css('ul#carpools li.driver', :count => 1)
  page.should have_css('ul#carpools li.driver', :text => 'Jeff')
end

Then /^he should see (\d+) empty slots for passengers$/ do |free_seats|
  page.should have_css('ul#carpools li.passenger', :count => free_seats.to_i)
end
