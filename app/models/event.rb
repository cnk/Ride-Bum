class Event < ActiveRecord::Base
  attr_accessible :name, :destination, :arrival_time

  validates :name,          presence: true
  validates :destination,   presence: true
  validates :arrival_time,  presence: true
  validates :user_id,       presence: true

  belongs_to :user
  has_many :invitations
end
