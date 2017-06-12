class WelcomeEmailWorker
  include Sidekiq::Worker

  def perform(email, password)
    UserMailer.welcome_email(email, password).deliver_now
  end
end
