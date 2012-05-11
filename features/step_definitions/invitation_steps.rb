When /^he types "([^"]*)" in the invitations field$/ do |text|
  @invitees ||= []
  @invitees << text
  fill_in "Invitations", with: @invitees.join("\n")
end

When /^clicks "([^"]*)"$/ do |text|
  click_on text
end

Then /^he should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Given /^the event has the following invitees:$/ do |table|
  # | name | email | phone |
  table.hashes.each do |row|
    FactoryGirl.create(:invitation, event: @event, user: FactoryGirl.create(:user, username: row[:name], email: row[:email], phone: row[:phone]))
  end
end

Given /^no invitation emails have been sent out$/ do
  Invitation.all.each do |invitation|
    invitation.email_sent = false
    invitation.save
  end
end

Given /^they have already received email invitations$/ do
  Invitation.all.each do |invitation|
    invitation.email_sent = true
    invitation.save
  end
end
