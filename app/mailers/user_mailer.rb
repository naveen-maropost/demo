class UserMailer < ApplicationMailer
	default :from => "maropost@mailinator.com"

  def contact_us_acknowledgement(obj)
  	@obj = obj
    mail(:to => obj.email, cc: "maropost@mailinator.com", :subject => "Thank you for letting us know")
  end

  def welcome_email(user)
  	@user = user
    mail(:to => user.email, cc: "maropost@mailinator.com", :subject => "Welcome To Maropost")
  end
end
