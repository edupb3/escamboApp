class Members::SessionsController < Devise::SessionsController
  
  def new
    super do |resource|
      resource.build_profile_menber
    end
  end
  
  protected
    def after_sign_in_path_for(resource)
      
      stored_location = stored_location_for(resource)
      
      if (stored_location.match(site_ads_details_path) )
        stored_location
      else
        site_profile_dashboard_index_path
      end
    end
    
end
