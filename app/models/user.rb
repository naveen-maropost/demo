class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_validation :generate_password, :on => :create
  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def password_required?
    return false
  end

  def generate_password
    password = (('a'..'z').to_a).sort_by { rand }.join[0..1]  + (('0'..'9').to_a).sort_by { rand }.join[0..6] + (('A'..'Z').to_a).sort_by { rand }.join[0...1]
    self.password = password
  end
end
