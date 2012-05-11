require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
                                       :name => "Name",
                                       :destination => "Destination"))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Destination/)
  end

  it "has a link back to the event list page" do
     render
    assert_select "a[href=?]", events_path
  end

  it "has a link edit the event" do
    render
    assert_select "a[href=?]", edit_event_path(@event), :text => "Edit"
  end

  it "has a link add invitations" do
    render
    assert_select "a[href=?]", edit_event_path(@event), :text => "Edit"
  end

  it "has a link email invitees" do
    render
    assert_select "a[href=?]", send_emails_event_invitations_path(@event), :text => "Send email to all invitees"
  end

end
