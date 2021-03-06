class Backoffice::SendMailController < ApplicationController
  
  def edit
    @admin = Admin.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  def create
    begin
      AdminMailer.notify_admin(params[:'recipient-name'], params[:'subject-text'], params[:'message-text']).deliver_now
      @notify_message = I18n.t('messages.email_delivered')
      @notify_flag = 'success'
    rescue
      @notify_message = I18n.t('messages.email_not_delivered')
      @notify_flag = 'error'
    end
    
    respond_to do |format|
      format.js
    end
    
  end
   
  
end
