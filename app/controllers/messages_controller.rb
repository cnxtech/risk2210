class MessagesController < ApplicationController

  before_filter :login_required

  def index
    if params[:filter].present? && params[:filter] == 'sent'
      self.active_tab = :sent
      @messages = current_player.sent_messages
    else
      self.active_tab = :inbox
      @messages = current_player.messages
    end
  end

  def new
    self.active_tab = :new_message
    if params[:recipient]
      recipient = Player.find(params[:recipient])
      @message = Message.new(recipient: recipient)
    else
      @message = Message.new
    end
  end

  def create
    self.active_tab = :new_message
    @message = current_player.sent_messages.build(message_params)
    if @message.save
      redirect_to messages_path, notice: "Message created!"
    else
      flash.now.alert = "There was an error saving your message"
      render action: :new
    end
  end

private

  def message_params
    params.require(:message).permit(:body, :subject, :recipient_id)
  end

end
