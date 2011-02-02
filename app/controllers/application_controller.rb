class ApplicationController < ActionController::Base
  protect_from_forgery


  #load_and_authorize_resource #for cancan

  #rescue_from CanCan::AccessDenied do |exception|
  #  flash[:alert] = exception.message
  #  redirect_to root_url
  #end
  include Canable::Enforcers

  rescue_from Canable::Transgression do |e|
    flash[:alert] = "Permission Denied. Please contact your company administrator for further details."
    redirect_to root_url
  end

end
