class ApplicationController < ActionController::Base
  protect_from_forgery

  # What should we do if another controller action throws an AccessDenied exception?
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to root_path, :alert => exception.message
  end
end
