require 'spec_helper'

describe "rides/show" do
  before(:each) do
    @event = mock_model(Event,
                        :name => "Event Name")
    @user = mock_model(User,
                       :username => "Driver's name")
    @ride = assign(:ride, stub_model(Ride,
      :event_id => @event.id,
      :driver_id => @user.id,
      :free_seats => 3
    ))
    @ride.stub(:event).and_return @event
    @ride.stub(:driver).and_return @user
  end

  it "displays the number of free seats" do
    render
    rendered.should match(/3/)
  end
  it "displays the event name" do
    render
    rendered.should match(/#{@event.name}/)
  end
  it "displays the driver's username" do
    render
    rendered.should match(/#{@user.username}/)
  end
end
