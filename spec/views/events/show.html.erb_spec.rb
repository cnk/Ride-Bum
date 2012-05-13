require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = FactoryGirl.create(:event)
  end

  it "renders attributes" do
    render
    rendered.should match(/Name/)
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
