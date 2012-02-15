# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    destination "MyString"
    arrival_time { 30.days.from_now }
  end
end
