# == Schema Information
# Schema version: 20120513044545
#
# Table name: invitations
#
#  id         :integer         not null, primary key
#  event_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  email_sent :boolean         default(FALSE)
#  user_id    :integer
#

class Invitation < ActiveRecord::Base
  belongs_to :event, dependent: :destroy 
  belongs_to :user
  accepts_nested_attributes_for :user

  scope :unsent, where(email_sent: false)

  def send_email
    Notifier.invitation(self).deliver!
  end
end
