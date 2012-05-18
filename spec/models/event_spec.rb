# == Schema Information
# Schema version: 20120513044545
#
# Table name: events
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  destination  :string(255)
#  arrival_time :datetime
#  user_id      :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe Event do
  context "Required fields" do
    it "should require name" do
      event_without_a_name = FactoryGirl.build(:event, name: nil)
      event_without_a_name.should_not be_valid
      event_without_a_name.errors.should have_key(:name)
    end
    it "should require destination" do
      event_without_a_destination = FactoryGirl.build(:event, destination: nil)
      event_without_a_destination.should_not be_valid
      event_without_a_destination.errors.should have_key(:destination)
    end
    it "should require arrival time" do
      event_without_an_arrival_time = FactoryGirl.build(:event, arrival_time: nil)
      event_without_an_arrival_time.should_not be_valid
      event_without_an_arrival_time.errors.should have_key(:arrival_time)
    end
    it "should belong to a user" do
      event_without_a_user = FactoryGirl.build(:event, user_id: nil)
      event_without_a_user.should_not be_valid
      event_without_a_user.errors.should have_key(:user_id)
    end
  end

  it "should not allow user_id to be changed by mass_assignment" do
    expect do
      Event.new(user_id: 1)
    end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  it "should belong to a user" do
    Event.new.should respond_to(:user)
  end

  it "should have invitations" do
    Event.new.should respond_to(:invitations)
  end
end
