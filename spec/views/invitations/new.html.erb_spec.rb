require 'spec_helper'

describe "invitations/new" do
  before(:each) do
    @event = assign(:event, mock_model(Event,
                                       :name => "MyString",
                                       :destination => "MyString"
                                       ))
    @user = assign(:user, stub_model(User).as_new_record)
    assign(:invitation, stub_model(Invitation, user: 
                                   @user, 
                                   event: @event).as_new_record)
  end

  it "renders new invitation form" do
    render

    assert_select "form", :action => invitations_path, :method => "post" do
      assert_select "input#invitation_event_id", :name => "invitation[event_id]"
      assert_select "input#invitation_user_attributes_username", :name => "invitation[user_attributes][username]"
      assert_select "input#invitation_user_attributes_email", :name => "invitation[user_attributes][email]"
      assert_select "input#invitation_user_attributes_phone", :name => "invitation[user_attributes][phone]"
    end
  end

  it "has a link back to the event page" do
    render
    assert_select "a[href=?]", event_path(@event)
  end
end
