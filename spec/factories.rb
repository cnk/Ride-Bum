FactoryGirl.define do
  factory :event do
    name "MyString"
    destination "MyString"
    arrival_time { 2.days.from_now }
    user
  end

  factory :invitation do
    association :user, factory: :invitee
    event
  end

  factory :ride do
    association :driver, factory: :invitee
    event
    free_seats 3
  end

  factory :user do
    sequence :username, 1000 do
      "username_#{n}"
    end
    email { "#{username}@example.com" }
    password { "abc123" }
    password_confirmation { "abc123" }
  end

  factory :invitee, class: User do
    sequence :phone, 1000000000 do |n|
      n.to_s
    end
    sequence :username, 1000 do
      "username_#{n}"
    end
    email { "#{username}@example.com" }
  end
end
