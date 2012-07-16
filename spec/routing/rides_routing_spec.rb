require "spec_helper"

describe RidesController do
  describe "routing" do

    it "routes to #index" do
      get("/events/2/rides").should route_to("rides#index", :event_id => "2")
    end

    it "routes to #new" do
      get("/events/2/rides/new").should route_to("rides#new", :event_id => "2")
    end

    it "routes to #show" do
      get("/events/2/rides/1").should route_to("rides#show", :event_id => "2", :id => "1")
    end

    it "routes to #edit" do
      get("/events/2/rides/1/edit").should route_to("rides#edit", :event_id => "2", :id => "1")
    end

    it "routes to #create" do
      post("/events/2/rides").should route_to("rides#create", :event_id => "2")
    end

    it "routes to #update" do
      put("/events/2/rides/1").should route_to("rides#update", :event_id => "2", :id => "1")
    end

    it "routes to #destroy" do
      delete("/events/2/rides/1").should route_to("rides#destroy", :event_id => "2", :id => "1")
    end

  end
end
