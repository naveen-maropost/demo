class ContactusEmailWorker
  include Sidekiq::Worker

  def perform(name, email)
    UserMailer.contact_us_acknowledgement(name, email).deliver_now
  end
end
