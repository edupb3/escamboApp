class ApplicationController < ActionController::Base
  
  before_action :store_user_location!, :unless => :devise_controller?

  include Pundit
  
  # Rescuing a denied Authorization in Rails
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout :layout_by_resource
  
  protected
  
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
  
  private
      
    def storable_location?
      puts "request.get -> #{request.get?} "
      puts "is_navigational_format? -> #{is_navigational_format?} "
      puts "!devise_controller? -> #{!devise_controller?} "
      puts "!request.xhr? -> #{!request.xhr?} "
      puts "retorno -> #{request.get? && is_navigational_format? && !devise_controller? && !request.xhr? } "
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end
  
    def store_user_location!        
      store_location_for(:member, request.fullpath)
    end
  
end
