class PlayerMailer < ActionMailer::Base

  default from: Rails.configuration.settings.email.default_from
  layout "application_mailer"

  def welcome_email(player)
    @player = player
    mail(to: player.email, subject: "Welcome to Risk2210.net")
  end

  def password_reset(player)
    @player = player
    mail(to: player.email, subject: "Risk2210.net Password Reset")
  end

end
