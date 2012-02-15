FactoryGirl.define do
  factory :event_planner do
    # ??
  end

  factory :user, :class => User do
    provider        "identity"
    sequence(:uid)  {|n| "#{n}"} 
    name            "Basic User"
  end

  factory :google_user, :class => User do
    provider        "google"
    sequence(:uid)  {|n| "#{n}"} 
    name            "Google User"
  end
  
  factory :local_user, :class => User do
    # For convenience, I want to pass identity configuration to local_user
    ignore do
      name "Jane Roe"
      sequence(:email)        {|n| "user#{n}@example.org" }
    end

    provider   "identity"
    uid         {FactoryGirl.create(:identity, :name => name, :email => email).id}
  end
  
  factory :identity do
    name                    "Jone Roe"
    sequence(:email)        {|n| "user#{n}@example.com" }
    password                "password"
    password_confirmation   "password"
  end
  
end
