class UserMailer < ActionMailer::Base
  default from: 'notifications@latinfoods.com'
 
  def welcome_email(contact)
  	@contact = contact
    mail(to: 'anilapu@navaratan.com', subject: "Email from Latinfoods")
  end
end
