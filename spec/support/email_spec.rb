# Example app edited spec_helper to include these 
# But I am hoping they work OK from a new file
# http://railsapps.github.com/tutorial-rails-devise-rspec-cucumber.html
RSpec.configure do |config|
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
end
