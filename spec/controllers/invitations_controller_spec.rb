require 'spec_helper'

describe InvitationsController do
  # Invitations is nested under events, so all tests will need an event - and most an invitation
  before(:each) do
    user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event, user: user)
    login_as user
  end
  let(:invitation) { FactoryGirl.create(:invitation, event:@event) }

  def valid_attributes
    {"event_id" => @event.id,
     "user_attributes" => {"username" => "Guest 1", "email" => "guest@example.com",  "phone" => "3232"}}
  end

  describe "GET index" do
    it "assigns all invitations as @invitations" do
      # Couldn't just use the invitation from let w/o calling it somewhere before the get, 
      # so might as well make a new invitation
      invite = FactoryGirl.create(:invitation, event:@event) 
      get :index, {:event_id => @event.id}
      response.should be_success
      assigns(:invitations).should eq([invite])
    end
  end

  describe "GET show" do
    it "assigns the requested invitation as @invitation" do
      get :show, {:id => invitation.to_param, :event_id => @event.id}
      response.should be_success
      assigns(:invitation).should eq(invitation)
    end
  end

  describe "GET new" do
    it "assigns a new invitation as @invitation" do
      get :new, {:event_id => @event.id}
      response.should be_success
      assigns(:invitation).should be_a_new(Invitation)
    end
  end

  describe "GET edit" do
    it "assigns the requested invitation as @invitation" do
      get :edit, {:id => invitation.to_param, :event_id => @event.id}
      response.should be_success
      assigns(:invitation).should eq(invitation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Invitation" do
        expect {
          post :create, {:event_id => @event.id, :invitation => valid_attributes}
        }.to change(Invitation, :count).by(1)
      end

      it "assigns a newly created invitation as @invitation" do
        post :create, {:event_id => @event.id, :invitation => valid_attributes}
        assigns(:invitation).should be_a(Invitation)
        assigns(:invitation).should be_persisted
      end

      it "redirects to the created invitation" do
        post :create, {:event_id => @event.id, :invitation => valid_attributes}
        response.should redirect_to(@event)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved invitation as @invitation" do
        # Trigger the behavior that occurs when invalid params are submitted
        Invitation.any_instance.stub(:save).and_return(false)
        post :create, {:event_id => @event.id, :invitation => valid_attributes}
        assigns(:invitation).should be_a_new(Invitation)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Invitation.any_instance.stub(:save).and_return(false)
        post :create, {:event_id => @event.id, :invitation => valid_attributes}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested invitation" do
        # Assuming there are no other invitations in the database, this
        # specifies that the Invitation created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update_attributes).with(valid_attributes["user_attributes"])
        put :update, {:event_id => @event.id, :id => invitation.to_param, :invitation => valid_attributes}
      end

      it "assigns the requested invitation as @invitation" do
        put :update, {:event_id => @event.id, :id => invitation.to_param, :invitation => valid_attributes}
        assigns(:invitation).should eq(invitation)
      end

      it "redirects to the invitation" do
        put :update, {:event_id => @event.id, :id => invitation.to_param, :invitation => valid_attributes}
        response.should redirect_to(event_invitation_path(invitation.event_id, invitation.id))
      end
    end

    describe "with invalid params" do
      it "assigns the invitation as @invitation" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:event_id => @event.id, :id => invitation.to_param, :invitation => {}}
        assigns(:invitation).should eq(invitation)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:event_id => @event.id, :id => invitation.to_param, :invitation => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested invitation" do
      # need the invitation created before the expect block so we can get a before and after count
      my_invitation = FactoryGirl.create(:invitation, event_id: @event.id)
      expect {
        delete :destroy, {:event_id => @event.id, :id => my_invitation.to_param}
      }.to change(Invitation, :count).by(-1)
    end

    it "redirects to the invitations list" do
      delete :destroy, {:event_id => @event.id, :id => invitation.to_param}
      response.should redirect_to(event_url(@event.id))
    end
  end

end
