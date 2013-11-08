require 'spec_helper'

describe RidesController do
  # For permission testing we just need some stock data
  # Not super important it be fresh for every test
  before(:all) do
    @event_planner = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event, user: @event_planner)
    @invitee = FactoryGirl.create(:invitee)
    @invitation = FactoryGirl.create(:invitation, event: @event, user: @invitee)
    @ride = FactoryGirl.create(:ride, event: @event, driver: @invitee)
    @someone_elses_ride = FactoryGirl.create(:ride, event: @event)
    @unprivileged_user = FactoryGirl.create(:user, username: "nobody" )
  end

  after(:all) do
    @ride.destroy
    @invitation.destroy
    @invitee.destroy
    @event.destroy
    @event_planner.destroy
    @unprivileged_user.destroy
  end

  def valid_form_attributes
    {"free_seats" => 2}
  end

  context "as a guest user" do
    describe "may not access any ride actions:" do
      {"index" => "get", "new" => "get", "create" => "put"}.each do |action, method|
        it "can't access the Ride##{action} action" do
          send(method, action, :event_id => @event.id)
          response.should redirect_to(new_user_session_path)
          flash[:alert].should eql("You need to sign in or sign up before continuing.")
        end
      end

      {"show" => "get", "edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can't access the Ride##{action} action" do
          send(method, action, :event_id => @event.id, :id => @ride.id)
          response.should redirect_to(new_user_session_path)
          flash[:alert].should eql("You need to sign in or sign up before continuing.")
        end
      end
    end
  end

  context "as someone invited to an event" do
    describe "can access actions for the event's rides:" do
      before(:each) { login_as @invitee }

      {"index" => "get", "new" => "get"}.each do |action, method|
        it "can access the Ride##{action} action" do
          send(method, action, :event_id => @event.id)
          response.should be_success
          assigns(:rides).should eq([@ride]) if action == "index"
        end
      end

      # have to handle create and update separately because of the user_attributes in the form
      it "can access the Ride#create action" do
        post :create, {:event_id => @event.id, :ride => valid_form_attributes}
        response.should redirect_to(event_path(@event.id))
        assigns(:event).should eq(@event) 
      end

      it "can access the Ride#update action - for the ride they created" do
        put :update, {:event_id => @event.id, :id => @ride.id, :ride => valid_form_attributes}
        response.should redirect_to(event_ride_path(@event.id, @ride.id))
        assigns(:ride).should eq(@ride) 
      end

      it "can not access the Ride#update action for someone else's ride" do
        put :update, {:event_id => @event.id, :id => @someone_elses_ride.id, :ride => valid_form_attributes}
        response.should redirect_to(root_path)
        flash[:alert].should eql("You are not authorized to access this page.")
      end
      
      {"show" => "get", "edit" => "get", "destroy" => "delete"}.each do |action, method|
        it "can access the Ride##{action} action for their ride" do
          send(method, action, :event_id => @event.id, :id => @ride.id)
          response.should be_success if ["show", "edit"].include?(action)
          response.should redirect_to(event_url(@event)) if action == "destroy"
          response.should redirect_to(event_url(@event.id)) if action == "update"
          assigns(:ride).should eq(@ride) unless action == "destroy"
        end
      end

      it "can access the Ride#show action for anyone's ride" do
          get :show, :event_id => @event.id, :id => @someone_elses_ride.id
          response.should be_success
          assigns(:ride).should eq(@someone_elses_ride)
      end

      {"edit" => "get", "destroy" => "delete"}.each do |action, method|
        it "can not access the Ride##{action} action for someone else's ride" do
          send(method, action, :event_id => @event.id, :id => @someone_elses_ride.id)
          response.should be_success if action ==  "edit"
          response.should redirect_to(event_url(@event)) if action == "destroy"
          assigns(:ride).should eq(@ride) unless action == "destroy"
        end
      end

    end
  end

  # context "as the event's owner" do
  #   describe "can access all actions for their event's rides:" do
  #     before(:each) { login_as @event_planner }

  #     {"index" => "get", "new" => "get"}.each do |action, method|
  #       it "can access the Ride##{action} action" do
  #         send(method, action, :event_id => @event.id)
  #         response.should be_success
  #         assigns(:rides).should eq([@ride]) if action == "index"
  #       end
  #     end

  #     # have to handle create and update separately because of the user_attributes in the form
  #     it "can access the Ride#create action" do
  #       post :create, {:event_id => @event.id, :ride => valid_form_attributes}
  #       response.should redirect_to(event_path(@event.id))
  #       assigns(:event).should eq(@event) 
  #     end

  #     it "can access the Ride#update action" do
  #       put :update, {:event_id => @event.id, :id => @ride.id, :ride => valid_form_attributes}
  #       response.should redirect_to(event_ride_path(@event.id, @ride.id))
  #       assigns(:ride).should eq(@ride) 
  #     end
      
  #     {"show" => "get", "edit" => "get", "destroy" => "delete"}.each do |action, method|
  #       it "can access the Ride##{action} action" do
  #         send(method, action, :event_id => @event.id, :id => @ride.id)
  #         response.should be_success if ["show", "edit"].include?(action)
  #         response.should redirect_to(event_url(@event)) if action == "destroy"
  #         response.should redirect_to(event_ride_url(@event.id, @ride.id)) if action == "update"
  #         assigns(:ride).should eq(@ride) unless action == "destroy"
  #       end
  #     end

  #   end
  # end

  context "as a different user" do
    before(:each) { login_as @unprivileged_user }
    describe "may not access any ride actions for an event they don't own and are not invited to:" do
      {"index" => "get", "new" => "get", "create" => "put"}.each do |action, method|
        it "can't access the Ride##{action} action" do
          send(method, action, :event_id => @event.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You are not authorized to access this page.")
        end
      end

      {"show" => "get", "edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can't access the Ride##{action} action" do
          send(method, action, :event_id => @event.id, :id => @ride.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You are not authorized to access this page.")
        end
      end
    end
  end

end
