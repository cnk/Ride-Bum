class Event < ActiveRecord::Base
  validates :name,          presence: true
  validates :destination,   presence: true
  validates :arrival_time,  presence: true
  validates :user_id,       presence: true

  belongs_to :user
  has_many :invitations
end
