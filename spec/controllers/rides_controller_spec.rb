require 'spec_helper'

describe RidesController do
  # Rides are nested under events, so all tests will need an event - and most a ride
  before(:each) do
    user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event, user: user)
    login_as user
  end
  let(:ride) { FactoryGirl.create(:ride, event:@event) }

  def valid_attributes
    { :free_seats => 3 }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RidesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all rides as @rides" do
      # Couldn't just use the ride from let w/o calling it somewhere before the get, 
      # so might as well make a new ride
      ride = FactoryGirl.create(:ride, event:@event) 
      get :index, { event_id: @event.id }
      assigns(:rides).should eq([ride])
    end
  end

  describe "GET show" do
    it "assigns the requested ride as @ride" do
      get :show, {:event_id => @event.id, :id => ride.to_param}
      assigns(:ride).should eq(ride)
    end
  end

  describe "GET new" do
    it "assigns a new ride as @ride" do
      get :new, {:event_id => @event.id}
      assigns(:ride).should be_a_new(Ride)
    end
  end

  describe "GET edit" do
    it "assigns the requested ride as @ride" do
      get :edit, {:event_id => @event.id, :id => ride.to_param}
      assigns(:ride).should eq(ride)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Ride" do
        expect {
          post :create, {:event_id => @event.id, :ride => valid_attributes}
        }.to change(Ride, :count).by(1)
      end

      it "assigns a newly created ride as @ride" do
        post :create, {:event_id => @event.id, :ride => valid_attributes}
        assigns(:ride).should be_a(Ride)
        assigns(:ride).should be_persisted
      end

      it "redirects to the created ride" do
        post :create, {:event_id => @event.id, :ride => valid_attributes}
        response.should redirect_to(event_path(@event))
      end
    end

    describe "with invalid params" do
      before(:each) do
        # Trigger the behavior that occurs when invalid params are submitted
        Ride.any_instance.stub(:save).and_return(false)
        post :create, {:event_id => @event.id, :ride => valid_attributes}
      end

      it "assigns a newly created but unsaved ride as @ride" do
        assigns(:ride).should be_a_new(Ride)
      end

      it "re-renders the 'new' template" do
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ride" do
        put :update, {:event_id => @event.id, :id => ride.to_param, :ride => { :free_seats => 4}}
      end

      it "assigns the requested ride as @ride" do
        put :update, {:event_id => @event.id, :id => ride.to_param, :ride => { :free_seats => 4}}
        assigns(:ride).should eq(ride)
      end

      it "redirects to the event's rides page" do
        put :update, {:event_id => @event.id, :id => ride.to_param, :ride => { :free_seats => 4}}
        response.should redirect_to(event_rides_path(@event))
      end
    end

    describe "with invalid params" do
      it "assigns the ride as @ride" do
        # Trigger the behavior that occurs when invalid params are submitted
        put :update, {:event_id => @event.id, :id => ride.to_param, :ride => { :free_seats => nil}}
        assigns(:ride).should eq(ride)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        put :update, {:event_id => @event.id, :id => ride.to_param, :ride => { :free_seats => nil}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested ride" do
      # need the ride created before the expect block so can't use the ride provided by the let
      my_ride = FactoryGirl.create(:ride, event_id: @event.id)
      expect {
        delete :destroy, {:event_id => @event.id, :id => my_ride.id}
      }.to change(Ride, :count).by(-1)
    end

    it "redirects to the rides list" do
      delete :destroy, {:event_id => @event.id, :id => ride.to_param}
      response.should redirect_to(event_rides_path(@event))
    end
  end

end
