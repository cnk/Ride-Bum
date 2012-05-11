require 'spec_helper'

describe "events/index" do
  before(:each) do
      @event = stub_model(Event,
                          :name => "Name",
                          :destination => "Destination"
                          )
    @another = stub_model(Event,
                          :name => "Name",
                          :destination => "Destination"
                          )
    assign(:events, [@event, @another])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Destination".to_s, :count => 2
  end

  it "has a link show an event's details" do
    render
    assert_select "a[href=?]", event_path(@event)
  end

  it "has a link edit the event" do
    render
    assert_select "a[href=?]", edit_event_path(@event), :text => "Edit"
  end

  it "has a link delete the event" do
    render
    assert_select "a[href=/events/#{@event.id}]", :method => 'delete', :text => "Delete"
  end

  it "has a link add a new event" do
    render
    assert_select "a[href=?]", new_event_path(), :text => "New Event"
  end

end
