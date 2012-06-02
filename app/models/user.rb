# == Schema Information
# Schema version: 20120513044545
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  username               :string(255)
#  phone                  :string(255)
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :phone
  attr_accessor :login

  # For invitees, we need a token they can authenticate with. Let's add that globally.
  before_save :ensure_authentication_token

  # event planners own events
  has_many :events

  # invitees will have invitations
  has_many :invitations

  scope :invitees, joins(:invitations)

  # Sadly, we can't use this while creating a user to see if we need a
  # token or password because we need the user so we can create the invitation
  def is_an_invitee?
    self.invitations.size > 0
  end

  # Later we may use some other criteria to distinguish event planners
  # But for now, event planners have passwords and invitees don't
  def is_an_event_planner?
    !self.encrypted_password.blank?
  end

  protected
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(['lower(username) = :value OR lower(email) = :value', { :value => login.downcase }]).first
  end

  def password_required?
    false
  end
end
