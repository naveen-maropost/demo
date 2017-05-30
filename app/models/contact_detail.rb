class ContactDetail < ApplicationRecord

	after_save :send_acknowledgement

  def send_acknowledgement
    UserMailer.contact_us_acknowledgement(self).deliver_now
  end
end
