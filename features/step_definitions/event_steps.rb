Given /^he is on the "([^"]*)" event page$/ do |event_name|
  visit event_path(Event.find_by_name(event_name))
end

Given /^there is a "([^"]*)" event$/ do |event_name|
  @event = FactoryGirl.create(:event, name: event_name)
end

Given /^he has created the "([^"]*)" event$/ do |event_name|
  @event = FactoryGirl.create(:event, name: event_name)
puts "Create event without owner until we add user_id to events table"
#  @event = FactoryGirl.create(:event, name: event_name, user: @user)
end

When /^he enters the destination "([^"]*)"$/ do |destination|
  fill_in "Destination", with: destination
end

When /^he enters the name "([^"]*)"$/ do |name|
  fill_in "Event Name", with: name
end

When /^he enters the start date and time "([^"]*)"$/ do |datetime|
  time = DateTime.parse(datetime)
  select time.year.to_s,      from: "event[arrival_time(1i)]"
  select time.strftime("%B"), from: "event[arrival_time(2i)]"
  select time.day.to_s,       from: "event[arrival_time(3i)]"
  select time.hour.to_s,      from: "event[arrival_time(4i)]"
  select time.minute.to_s,    from: "event[arrival_time(5i)]"
  # datetime selection
end

Then /^he is on the event's page$/ do
  # which event?  we have no event variable at this point
  Event.last
end
