class ApplicationController < ActionController::Base
  protect_from_forgery
  #load_and_authorize_resource #for cancan

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end


end
