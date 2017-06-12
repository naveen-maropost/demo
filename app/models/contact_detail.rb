class ContactDetail < ApplicationRecord
  validates :name, presence: {message: "Please enter name."}
  validates :name, :format => { :with => /\A[A-Za-z ][A-Za-z ]*\z/,:message => "Only letters allowed" }
  validates :email, presence: {message: "Please enter email."}
  validates :mobile_number, presence: {message: "Please enter mobile number."}
  validates :description, presence: {message: "Please enter description."}
  after_save :send_acknowledgement

  def send_acknowledgement
    ContactusEmailWorker.perform_async(self.name, self.email)
  end
end
