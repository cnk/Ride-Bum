# http://pivotallabs.com/users/mgehard/blog/articles/1595-testing-omniauth-based-login-via-cucumber
Before('@omniauth_test') do
  OmniAuth.config.test_mode = true
  
  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:twitter] = {
    "provider"=>"twitter",
    "uid"=>"http://xxxx.com/openid?id=11818113899",
    "info"=>{"email"=>"test@example.com", "first_name"=>"Twitter", "last_name"=>"User", "name"=>"Twitter User"}
  }
  
  OmniAuth.config.mock_auth[:google] = {
    "provider"=>"google",
    "uid"=>"http://xxxx.com/openid?id=118181138998978630963",
    "info"=>{"email"=>"test@example.com", "first_name"=>"Google", "last_name"=>"User", "name"=>"Google User"}
  }
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
