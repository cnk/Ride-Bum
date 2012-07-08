# == Schema Information
# Schema version: 20120513044545
#
# Table name: invitations
#
#  id         :integer         not null, primary key
#  event_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  email_sent :boolean         default(FALSE)
#  user_id    :integer
#

require 'spec_helper'

describe Invitation do
  it "should belong to an event" do
    Invitation.new.should respond_to(:event)
  end

  it "should belong to a user" do
    Invitation.new.should respond_to(:user)
  end

  it "should have a scope 'unsent'" do
    Invitation.should respond_to(:unsent)
  end

  it "should not allow event_id to be changed by mass_assignment" do
    expect do
      Invitation.new(event_id: 1)
    end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  it "should not allow user_id to be changed by mass_assignment" do
    expect do
      Invitation.new(user_id: 1)
    end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

end
