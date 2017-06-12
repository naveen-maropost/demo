class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_validation :generate_password, :on => :create
  after_create :send_welcome_email
  #before_save :ensure_authentication_token

  def send_welcome_email
    WelcomeEmailWorker.perform_async(self.email, self.password)
    #UserMailer.welcome_email(self).deliver_now
  end

  def password_required?
    !persisted? ? false : !password.nil? || !password_confirmation.nil?
  end

  def generate_password
    password = (('a'..'z').to_a).sort_by { rand }.join[0..1]  + (('0'..'9').to_a).sort_by { rand }.join[0..6] + (('A'..'Z').to_a).sort_by { rand }.join[0...1]
    self.password = password
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = generate_secure_token_string
      break token unless User.where(authentication_token: token).first
    end
  end

  def generate_secure_token_string
    SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  end

  def reset_authentication_token
    self.authentication_token = generate_authentication_token
  end

end
