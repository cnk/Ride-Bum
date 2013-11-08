class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Event planners can manage events and invitations - but only for
    # their own events. NB I could not get the is_an_event_planner AND
    # only show event planners their own events to work with
    # load_and_authorize_resource So I have the authorization here and
    # a custom query in EventsController#index

    # any event planner can see a list of their events and create new ones
    can [:index, :create], Event if user.is_an_event_planner?
    # The event planner and their invitees can see the show page
    can :show, Event do |event|
      event.user_id == user.id || event.invitees.map(&:id).include?(user.id)
    end
    # The event planner can edit and delete their event
    can [:update, :destroy], Event, :user_id => user.id

    # event planners manage invitations to their events
    can :manage, Invitation, :event => { :user_id => user.id }

    # invitees can add, edit, and delete rides for events they have been invited to
    # can :manage, Ride, Event do |event|
    #   event.invitees.map(&:id).include?(user.id)
    # end
  end
end
