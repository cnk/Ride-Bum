# == Schema Information
# Schema version: 20120513044545
#
# Table name: events
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  destination  :string(255)
#  arrival_time :datetime
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  user_id      :integer
#

class Event < ActiveRecord::Base
  attr_accessible :name, :destination, :arrival_time

  validates :name,          presence: true
  validates :destination,   presence: true
  validates :arrival_time,  presence: true
  validates :user_id,       presence: true

  belongs_to :user
  has_many :invitations
end
