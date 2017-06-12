class UserMailer < ApplicationMailer
	default :from => "maropost@mailinator.com"

  def contact_us_acknowledgement(name, email)
  	@name = name
    mail(:to => email, cc: "maropost@mailinator.com", :subject => "Thank you for letting us know")
  end

  def welcome_email(user_email,user_password)
  	@user_email = user_email
  	@user_password = user_password
    mail(:to => user_email, cc: "maropost@mailinator.com", :subject => "Welcome To Maropost")
  end
end
