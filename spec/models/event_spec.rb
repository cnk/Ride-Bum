require 'spec_helper'

describe Event do
  context "Required fields" do
    it "should require name" do
      Factory.build(:event, name: nil).should_not be_valid
    end
    it "should require destination" do
      Factory.build(:event, destination: nil).should_not be_valid
    end
    it "should require arrival time" do
      Factory.build(:event, arrival_time: nil).should_not be_valid
    end
    it "should create a valid event" do
      Factory.build(:event).should be_valid
    end
  end
end
