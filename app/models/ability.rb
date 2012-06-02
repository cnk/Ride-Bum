class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Event planners can manage events and invitations - but only for
    # their own events. NB I could not get the is_an_event_planner AND
    # only show that EPs events to work with load_and_authorize_resource 
    # So I have the authorization here and a custom query in EventsController#index
    can [:index, :create], Event if user.is_an_event_planner?
    can :show, Event do |event|
      event.user_id == user.id || event.invitees.map(&:id).include?(user.id)
    end
    can [:update, :destroy], Event, :user_id => user.id

    can :manage, Invitation, :event => { :user_id => user.id }

    # invitees can see the events#show page for their eventa
    # 
    # CNK the rules below work just fine EXCEPT that putting it in
    # here interferes with load_resource for events#index for the
    # event planner. The generated SQL does an inner join between
    # events and invitations and that prevents events that don't have
    # invitees from being listed on the index page. For now I have
    # worked around this problem by loading the events for
    # events#index explicitly.
    # 
    # can :manage, Event, :user_id => user.id
    # can :read, Event do |event|
    #   event.invitees.include?(user.id)
    # end
    
  end
end
