require 'spec_helper'

describe InvitationsController do
  # For permission testing we just need some stock data
  # Not super important it be fresh for every test
  before(:all) do
    @user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event, user: @user)
    @invitation = FactoryGirl.create(:invitation, event:@event)
    @unprivileged_user = FactoryGirl.create(:user, username: "nobody" )
  end

  after(:all) do
    @event.destroy
    @user.destroy
    @invitation.destroy
    @unprivileged_user.destroy
  end

  def valid_form_attributes
    {"event_id" => @event.id,
     "user_attributes" => {"username" => "Guest 1", "email" => "guest@example.com",  "phone" => "3232"}}
  end

  context "as a guest user" do
    describe "may not access any invitation actions:" do
      {"index" => "get", "new" => "get", "create" => "put"}.each do |action, method|
        it "can't access the Invitation##{action} action" do
          send(method, action)
          response.should redirect_to(new_user_session_path)
          flash[:alert].should eql("You need to sign in or sign up before continuing.")
        end
      end

      {"show" => "get", "edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can't access the Invitation##{action} action" do
          send(method, action, :event_id => @event.id, :id => @invitation.id)
          response.should redirect_to(new_user_session_path)
          flash[:alert].should eql("You need to sign in or sign up before continuing.")
        end
      end
    end
  end

  context "as the event's owner" do
    describe "can access all actions for their event's invitations:" do
      before(:each) { login_as @user }

      {"index" => "get", "new" => "get"}.each do |action, method|
        it "can access the Invitation##{action} action" do
          send(method, action, :event_id => @event.id)
          response.should be_success
          assigns(:invitations).should eq([@invitation]) if action == "index"
        end
      end

      # have to handle create and update separately because of the user_attributes in the form
      it "can access the Invitation#create action" do
        post :create, {:event_id => @event.id, :invitation => valid_form_attributes}
        response.should redirect_to(event_path(@event.id))
        assigns(:event).should eq(@event) 
      end

      it "can access the Invitation#update action" do
        put :update, {:event_id => @event.id, :id => @invitation.id, :invitation => valid_form_attributes}
        response.should redirect_to(event_invitation_path(@event.id, @invitation.id))
        assigns(:invitation).should eq(@invitation) 
      end
      
      {"show" => "get", "edit" => "get", "destroy" => "delete"}.each do |action, method|
        it "can access the Invitation##{action} action" do
          send(method, action, :event_id => @event.id, :id => @invitation.id)
          response.should be_success if ["show", "edit"].include?(action)
          response.should redirect_to(event_url(@event)) if action == "destroy"
          response.should redirect_to(event_invitation_url(@event.id, @invitation.id)) if action == "update"
          assigns(:invitation).should eq(@invitation) unless action == "destroy"
        end
      end

    end
  end

  context "as a different user" do
    before(:each) { login_as @unprivileged_user }
    describe "may not access any invitation actions for an event they don't own:" do
      {"index" => "get", "new" => "get", "create" => "put"}.each do |action, method|
        it "can't access the Invitation##{action} action" do
          send(method, action, :event_id => @event.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You are not authorized to access this page.")
        end
      end

      {"show" => "get", "edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can't access the Invitation##{action} action" do
          send(method, action, :event_id => @event.id, :id => @invitation.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You are not authorized to access this page.")
        end
      end
    end
  end

end
