require 'spec_helper'

describe "rides/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
                                      :name => "Name",
                                      :destination => "Destination"
                                      ))
    @ride = assign(:ride, stub_model(Ride,
                                     :event_id => 1,
                                     :driver_id => 1,
                                     :free_seats => 1
                                     ))
  end

  it "renders the edit ride form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => event_rides_path(@event, @ride), :method => "post" do
      assert_select "input#ride_free_seats", :name => "ride[free_seats]"
    end
  end
end
