require "spec_helper"

describe InvitationsController do
  describe "routing" do

    it "routes to #index" do
      get("/events/2/invitations").should route_to("invitations#index", :event_id => "2")
    end

    it "routes to #new" do
      get("/events/2/invitations/new").should route_to("invitations#new", :event_id => "2")
    end

    it "routes to #show" do
      get("/events/2/invitations/1").should route_to("invitations#show", :event_id => "2", :id => "1")
    end

    it "routes to #edit" do
      get("/events/2/invitations/1/edit").should route_to("invitations#edit", :event_id => "2", :id => "1")
    end

    it "routes to #create" do
      post("/events/2/invitations").should route_to("invitations#create", :event_id => "2")
    end

    it "routes to #update" do
      put("/events/2/invitations/1").should route_to("invitations#update", :event_id => "2", :id => "1")
    end

    it "routes to #destroy" do
      delete("/events/2/invitations/1").should route_to("invitations#destroy", :event_id => "2", :id => "1")
    end

  end
end
