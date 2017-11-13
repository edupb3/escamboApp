class AdminMailer < ApplicationMailer
  
  def update_email(current_admin, admin)
    @current_admin = current_admin
    @admin = admin
    
    mail(to: @admin.email, subject: 'Atualização de dados')
  end
  
  def notify_admin(recipient, subject, message )
    @recipient = recipient
    @subject = subject
    @message = message
    
    mail(to: @recipient, subject: @subject)
  end
  
end
