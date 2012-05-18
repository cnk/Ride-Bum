class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :event
  authorize_resource :invitation, :through => :event

  # GET /events/3/invitations
  # GET /events/3/invitations.json
  def index
    @invitations = @event.invitations

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invitations }
    end
  end

  # GET /events/3/invitations/1
  # GET /events/3/invitations/1.json
  def show
    @invitation = Invitation.find(params[:id] )

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /events/3/invitations/new
  # GET /events/3/invitations/new.json
  def new
    @invitation = @event.invitations.build()
    @invitation.user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /events/3/invitations/1/edit
  def edit
    @invitation = Invitation.find(params[:id], include: :event )
  end

  # POST /events/3/invitations
  # POST /events/3/invitations.json
  def create
    @invitation = @event.invitations.build()
    @invitation.user = User.new(params[:invitation][:user_attributes])

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to event_path(@invitation.event_id), notice: "#{@invitation.user.username} has been added" }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render action: "new", event_id: params[:invitation][:event_id].to_i }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/3/invitations/1
  # PUT /events/3/invitations/1.json
  def update
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      if @invitation.user.update_attributes(params[:invitation][:user_attributes])
        format.html { redirect_to event_invitation_path(@invitation.event_id, @invitation.id), notice: 'Invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/3/invitations/1
  # DELETE /events/3/invitations/1.json
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to event_path(@invitation.event_id) }
      format.json { head :no_content }
    end
  end

  # GET /events/3/invitations/send_emails
  def send_emails
    @event = Event.find(params[:event_id])
    email_results = @event.invitations.unsent.map(&:send_email)
    if email_results.any? { |result| not result }
      #failure
      redirect_to event_invitations_path(@event), notice: "Email Unsuccessful"
    else
      #success
      redirect_to event_invitations_path(@event), notice: "Email Successful"
    end
  end
end
