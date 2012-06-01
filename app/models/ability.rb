class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Event planners can manage events and invitations - but only for their own events
    can :manage, Event, :user_id => user.id
    can :manage, Invitation, :event => { :user_id => user.id }

    # invitees can see the events#show page for their eventa
    can :read, Event, :invitations => { :user_id => user.id }
    # 
    # CNK the rule below works just fine EXCEPT that putting it in
    # here interferes with load_resource for events#index for the
    # event planner. The generated SQL does an inner join between
    # events and invitations and that prevents events that don't have
    # invitees from being listed on the index page. For now I have
    # worked around this problem by loading the events for
    # events#index explicitly.
    # 
    # can :read, Event do |event|
    #   event.invitees.include?(user.id)
    # end
    
  end
end
