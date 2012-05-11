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
  end
end
