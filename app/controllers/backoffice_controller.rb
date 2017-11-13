class BackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout "backoffice"
  
  def pundit_user
    current_admin #overide current_user
  end
  
end
                                                        