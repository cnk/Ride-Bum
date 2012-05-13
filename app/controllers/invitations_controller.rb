class InvitationsController < ApplicationController
  before_filter :authenticate_user!


  # GET /invitations
  # GET /invitations.json
  def index
    @event = Event.find(params[:event_id])
    @invitations = @event.invitations

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invitations }
    end
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @invitation = Invitation.find(params[:id], include: :event )

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/new
  # GET /invitations/new.json
  def new
    @event = Event.find(params[:event_id])
    @invitation = Invitation.new(event_id: @event.id, user: User.new)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/1/edit
  def edit
    @invitation = Invitation.find(params[:id])
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(event_id: params[:invitation][:event_id].to_i)
    @invitation.user = User.new(params[:invitation][:user_attributes])

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to event_path(@invitation.event), notice: "#{@invitation.user.username} has been added" }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render action: "new" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invitations/1
  # PUT /invitations/1.json
  def update
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      if @invitation.user.update_attributes(params[:invitation][:user_attributes])
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to invitations_url }
      format.json { head :no_content }
    end
  end

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
