class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  attr_accessor :topic_id

  belongs_to :player, index: true
  belongs_to :commentable, polymorphic: true, index: true
  has_many :comments, as: :commentable, dependent: :destroy

  after_create :update_topic_stats
  after_destroy :decrement_comment_counter

  validates_presence_of :body

  def topic
    commentable.is_a?(Comment) ? Topic.find(topic_id) : commentable
  end

  private

  def update_topic_stats
    topic.inc(:comment_count, 1)
    topic.update_attribute(:last_comment_at, Time.now)
  end

  def decrement_comment_counter
    topic.inc(:comment_count, -1)
  end

end
