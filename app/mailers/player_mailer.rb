class PlayerMailer < ActionMailer::Base
  
  default from: "admin@risk2210.net"
  layout "application_mailer"
  
  def welcome_email(player)
    @player = player
    mail(:to => player.email, :subject => "Welcome to Risk2210.net!")
  end
  
end
