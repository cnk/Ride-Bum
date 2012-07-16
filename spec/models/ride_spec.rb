require 'spec_helper'

describe Ride do
  context "Required fields" do
    it "should require event_id" do
      ride_without_an_event = FactoryGirl.build(:ride, event: nil)
      ride_without_an_event.should_not be_valid
      ride_without_an_event.errors.should have_key(:event_id)
    end
    it "should require driver_id" do
      ride_without_a_driver = FactoryGirl.build(:ride, driver: nil)
      ride_without_a_driver.should_not be_valid
      ride_without_a_driver.errors.should have_key(:driver_id)
    end
    it "should require number of free seats" do
      ride_without_free_seats = FactoryGirl.build(:ride, free_seats: nil)
      ride_without_free_seats.should_not be_valid
      ride_without_free_seats.errors.should have_key(:free_seats)
    end
    it "should require free seats to be a number between 0 and 11" do
      ride = FactoryGirl.build(:ride)
      [nil, -1, 12].each do |val|
        ride.free_seats = val
        ride.should_not be_valid
        ride.errors.should have_key(:free_seats)
      end
      [0, 1, 11].each do |val|
        ride.free_seats = val
        ride.should be_valid
      end      
    end
  end

  it "should belong to a user - known as the driver" do
    Ride.new.should respond_to(:driver)
  end

  it "should belong to an event" do
    Ride.new.should respond_to(:event)
  end

  it "should not allow event_id to be changed by mass_assignment" do
    expect do
      Ride.new(event_id: 1)
    end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

end
