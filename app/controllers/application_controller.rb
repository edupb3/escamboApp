class ApplicationController < ActionController::Base
  
  before_action :store_member_location!, if: :storable_location?
  
  include Pundit
  
  # Rescuing a denied Authorization in Rails
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout :layout_by_resource
  
  private
  
  # Layout per resource_name AND action
  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "backoffice_devise"    
    elsif devise_controller? && resource_name == :member
      "site_devise"    
    else
      "application"
    end
  end
  
  # pundit
  def user_not_authorized
    flash[:alert] = I18n.t('messages.not_authorized')
    redirect_to(request.referrer || root_path)
  end
  
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end
  
  def store_member_location!
    puts "Request FullPath -> #{request.fullpath} "
    # :user is the scope we are authenticating
    store_location_for(:member, request.fullpath)
  end
  
end
