class Ride < ActiveRecord::Base
  attr_accessible :free_seats

  validates :event_id,      presence: true
  validates :driver_id,     presence: true
  validates :free_seats,    presence: true, :inclusion => { :in => 0..11 }

  belongs_to :event
  belongs_to :driver, class_name: User, foreign_key: :driver_id
end
