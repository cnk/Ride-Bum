require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "has a login route" do
      get("/login").should route_to("sessions#new")
    end

    it "has a logout route" do
      get("/logout").should route_to("sessions#destroy")
    end

    it "has a route for handling failed registrations" do
      get("/auth/failure").should route_to("sessions#failure")
    end

    it "has a route for the callback from OmniAuth identity - to create a new session" do
      get("/auth/identity/callback").should route_to(controller: 'sessions', action: 'create', provider: 'identity')
    end

  end
end
