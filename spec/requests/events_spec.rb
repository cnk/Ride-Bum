require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    it "works! (now write some real specs)" do
      get events_path
      # Fudge this now that the events controller requires authentication
      response.status.should be(302)
    end
  end
end
