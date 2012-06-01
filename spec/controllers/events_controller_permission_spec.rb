require 'spec_helper'

describe EventsController do
  # For permission testing we just need some stock data
  # Not super important it be fresh for every test
  before(:all) do
    @user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event, user: @user)
    @unprivileged_user = FactoryGirl.create(:user, username: "nobody" )
  end

  after(:all) do
    @event.destroy
    @user.destroy
    @unprivileged_user.destroy
  end

  context "as a guest user" do
    describe "may not access any event actions:" do
      {"index" => "get", "new" => "get", "create" => "put"}.each do |action, method|
        it "can't access the Event##{action} action" do
          send(method, action)
          response.should redirect_to(new_user_session_path)
          flash[:alert].should eql("You need to sign in or sign up before continuing.")
        end
      end

      {"show" => "get", "edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can't access the Event##{action} action" do
          send(method, action, :id => @event.id)
          response.should redirect_to(new_user_session_path)
          flash[:alert].should eql("You need to sign in or sign up before continuing.")
        end
      end
    end
  end

  context "as the event's owner" do
    describe "can access all actions for their events:" do
      before(:each) { login_as @user }
      {"index" => "get", "new" => "get", "create" => "put"}.each do |action, method|
        it "can access the Event##{action} action" do
          send(method, action)
          response.should be_success
          assigns(:events).should eq([@event]) if action == "index"
        end
      end

      {"show" => "get", "edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can access the Event##{action} action" do
          send(method, action, :id => @event.id)
          response.should be_success if ["show", "edit"].include?(action)
          response.should be_redirect if ["update", "destroy"].include?(action)
          assigns(:event).should eq(@event) unless action == "destroy"
        end
      end
    end
  end

  context "as a different user" do
    describe "can access the general actions:" do
      before(:each) { login_as @unprivileged_user }
      {"index" => "get", "new" => "get", "create" => "put"}.each do |action, method|
        it "can access the Event##{action} action" do
          send(method, action)
          response.should be_success
          assigns(:events).should eq([]) if action == "index"
        end
      end
    end
    describe "can't access the actions for someone else's event:" do
      before(:each) { login_as @unprivileged_user }
      {"show" => "get", "edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can not access the Event##{action} action" do
          send(method, action, :id => @event.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You are not authorized to access this page.")
        end
      end
    end
  end

  context "as someone invited to an  event" do
    describe "can only access the show page for their event:" do
      before(:each) { 
        invitation = FactoryGirl.create(:invitation, event:@event)
        login_as invitation.user 
      }
      
      it "can access the Event#show action" do
        get :show, :id => @event.id
        response.should be_success
        assigns(:event).should eq(@event)
      end

      {"index" => "get", "new" => "get", "create" => "put"}.each do |action, method|
        it "can not access the Event##{action} action" do
          send(method, action)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You are not authorized to access this page.")
        end
      end

      {"edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can not access the Event##{action} action" do
          send(method, action, :id => @event.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You are not authorized to access this page.")
        end
      end
    end
  end

end
