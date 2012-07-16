require 'spec_helper'

describe "rides/index" do
  before(:each) do
    @event = mock_model(Event,
                        :name => "Event Name")
    @user = mock_model(User,
                       :username => "Driver's name")
    @rides = assign(:rides, [
                             stub_model(Ride,
                                        :event_id => @event.id,
                                        :driver_id => @user.id,
                                        :free_seats => 3
                                        ),
                             stub_model(Ride,
                                        :event_id => @event.id,
                                        :driver_id => @user.id,
                                        :free_seats => 3
                                        )
                            ])
    @rides[0].stub(:event).and_return @event
    @rides[1].stub(:event).and_return @event
    @rides[0].stub(:driver).and_return @user
    @rides[1].stub(:driver).and_return @user
  end

  it "renders a list of rides showing event name, driver username, and number of free seats" do
    render
    assert_select "tr>td", :text => @event.name, :count => 2
    assert_select "tr>td", :text => @user.username, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
