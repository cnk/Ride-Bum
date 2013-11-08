class RidesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :event
  # CNK having trouble getting the CanCan permissions working
  # authorize_resource :ride, :through => :event

  # GET /events/1/rides
  # GET /events/1/rides.json
  def index
    @rides = @event.rides

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rides }
    end
  end

  # GET /events/1/rides/1
  # GET /events/1/rides/1.json
  def show
    @ride = @event.rides.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ride }
    end
  end

  # GET /events/1/rides/new
  # GET /events/1/rides/new.json
  def new
    @ride = @event.rides.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ride }
    end
  end

  # GET /events/1/rides/1/edit
  def edit
    @ride = @event.rides.find(params[:id])
  end

  # POST /events/1/rides
  # POST /events/1/rides.json
  def create
    @ride = @event.rides.new(params[:ride])
    # now fill in driver from current user
    @ride.driver_id = current_user.id

    respond_to do |format|
      if @ride.save
        format.html { redirect_to event_path(@event), notice: 'Thank you for offering to drive.' }
        # TODO CNK test location is correct - I think it may need to be /events/1/ride/1.json
        format.json { render json: @ride, status: :created, location: @ride }
      else
        format.html { render action: "new" }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1/rides/1
  # PUT /events/1/rides/1.json
  def update
    @ride = @event.rides.find(params[:id])

    respond_to do |format|
      if @ride.update_attributes(params[:ride])
        format.html { redirect_to event_rides_path(@event), notice: 'Your information was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1/rides/1
  # DELETE /events/1/rides/1.json
  def destroy
    @ride = @event.rides.find(params[:id])
    @ride.destroy

    respond_to do |format|
      format.html { redirect_to event_rides_path(@event) }
      format.json { head :no_content }
    end
  end
end
