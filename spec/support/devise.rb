module DeviseMacros
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user) 
  end

  def login_as(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include DeviseMacros, :type => :controller
end
