require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = FactoryGirl.create(:event)
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  it "renders attributes" do
    render
    rendered.should match(/Name/)
    rendered.should match(/Destination/)
  end

  context "the event planner should see admin links" do
    before(:each) do
      @ability.can :manage, Event
      render
    end
    
    it "has a link back to the event list page" do
      assert_select "a[href=?]", events_path
    end

    it "has a link edit the event" do
      assert_select "a[href=?]", edit_event_path(@event), :text => "Edit"
    end

    it "has a link add invitations" do
      assert_select "a[href=?]", edit_event_path(@event), :text => "Edit"
    end

    it "has a link email invitees" do
      assert_select "a[href=?]", send_emails_event_invitations_path(@event), :text => "Send email to all invitees"
    end
  end

  context "an invitee should not see admin links" do
    before(:each) do
      @ability.can :show, Event
      render
    end
    
    it "has a link back to the event list page" do
      assert_select "a[href=?]", events_path, false
    end

    it "has a link edit the event" do
      assert_select "a[href=?]", edit_event_path(@event), false
    end

    it "has a link add invitations" do
      assert_select "a[href=?]", edit_event_path(@event), false
    end

    it "has a link email invitees" do
      assert_select "a[href=?]", send_emails_event_invitations_path(@event), false
    end
  end

end
