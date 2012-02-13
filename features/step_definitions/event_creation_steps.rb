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
