# == Schema Information
#
# Table name: rides
#
#  id         :integer         not null, primary key
#  event_id   :integer
#  driver_id  :integer
#  free_seats :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Ride < ActiveRecord::Base
  attr_accessible :free_seats

  validates :event_id,      presence: true
  validates :driver_id,     presence: true
  validates :free_seats,    presence: true, :inclusion => { :in => 0..11 }

  belongs_to :event
  belongs_to :driver, class_name: User, foreign_key: :driver_id
end
