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
