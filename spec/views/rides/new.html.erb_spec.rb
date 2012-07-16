require 'spec_helper'

describe "rides/new" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
                                      :name => "Name",
                                      :destination => "Destination"
                                      ))
    assign(:ride, stub_model(Ride)).as_new_record
  end

  it "renders new ride form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => event_rides_path(@event), :method => "post" do
      assert_select "input#ride_free_seats", :name => "ride[free_seats]"
    end
  end
end
