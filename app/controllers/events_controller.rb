class EventsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:index]

  # GET /events
  # GET /events.json
  def index
    # ensure current user is an event planner
    authorize! :index, Event
    # Then pull out just his events
    @events = Event.where(["user_id = ?", current_user]).all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    respond_to do |format|
      format.html {
        @invitations = @event.invitations
        # need to set up some variables for the new invitation form
        @invitation = @event.invitations.build()
        @invitation.user = User.new
      }
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event.user = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'The event was created' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
