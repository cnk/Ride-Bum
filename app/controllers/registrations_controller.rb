class RegistrationsController < Devise::RegistrationsController
  protected
  
  def after_sign_up_path_for(resource)
    # the user's dashboard should probably be the events index page
    events_path
  end
end
