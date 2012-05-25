When /^he types "([^"]*)" in the invitations field$/ do |text|
  @invitees ||= []
  @invitees << text
  fill_in "Invitations", with: @invitees.join("\n")
end

When /^clicks "([^"]*)"$/ do |text|
  click_on text
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

Then /^he has invited "(.*?)" to the "(.*?)" event$/ do |invitee_name, event_name|
  event = Event.find_by_name!(event_name)
  invitation = event.invitations.build
  invitation.user = FactoryGirl.create(:user, username: invitee_name)
  invitation.save!
  invitation.send_email
end

When /^"(.*?)" clicks on the link in the invitation email$/ do |invitee_name|
  user = User.find_by_username!(invitee_name)
  invitation = Invitation.find_by_user_id!(user.id)
  # get the email that was sent and parse the link out of the body
  open_email(user.email)
  current_email.default_part_body.to_s[/http:\/\/localhost:3000([\/\?\w]*)/]
  visit $1
end
