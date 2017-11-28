class Members::SessionsController < Devise::SessionsController
  
  protected
  
    def after_sign_in_path_for(resource)
      
      stored_location = stored_location_for(resource) || super
      
      puts ">>> #{stored_location} <<<"
      
      if (stored_location.match('site/ad_details') )
        stored_location
      else
        site_profile_dashboard_index_path
      end
    end
    
end
