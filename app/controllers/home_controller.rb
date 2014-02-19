class HomeController < ApplicationController
 


  before_filter :authenticate_user!, :only => [:profile]


  
  def index
  end

  def profile
  end

  def organization
  end

  def wedo
  end

  def publications
  end

  def contact
    @contact = Contact.new
  end

  def save_details
    @contact = Contact.new(params[:contact])
      if @contact.save
        # flash[:notice] = 'Thank you for the email! We will get back to you.' 
        UserMailer.welcome_email(@contact).deliver
        redirect_to '/home/confirmation_message'
      else  
        flash[:errors] = [] 
        @contact.errors.full_messages.each do |error|
          flash[:errors] << error
      end
        redirect_to '/home/contact'
        # redirect_to home_contactus_path(@contact)
    end
  end

def confirmation_message
    
end

end
