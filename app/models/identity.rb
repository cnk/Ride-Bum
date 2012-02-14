class Identity < OmniAuth::Identity::Models::ActiveRecord 
  validates :name, :presence => true
  validates :email, :uniqueness => true, 
                    :format => { :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\Z/i }
end
