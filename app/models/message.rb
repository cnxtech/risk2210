class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body,    type: String
  field :subject, type: String

  belongs_to :recipient, class_name: "Player", inverse_of: :messages, index: true
  belongs_to :sender, class_name: "Player", inverse_of: :sent_messages, index: true

  after_create :notify_recipient

  validates_presence_of :subject, :body, :recipient

private

  def notify_recipient
  end

end
