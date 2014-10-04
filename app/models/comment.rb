class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  belongs_to :player, index: true
  belongs_to :commentable, polymorphic: true, index: true
  has_many :comments, as: :commentable, dependent: :destroy

  after_create :update_topic_stats
  after_destroy :decrement_comment_counter

  validates_presence_of :body

  def topic
    parent = commentable
    loop do
      return parent if parent.is_a?(Topic) || parent.is_a?(NilClass)
      parent = parent.commentable
    end
  end

  def commentable_label
    "Comment - #{body.truncate(30)}"
  end

private

  def update_topic_stats
    return if topic.nil?
    topic.inc(comment_count: 1)
    topic.update_attribute(:last_comment_at, Time.now)
  end

  def decrement_comment_counter
    topic.inc(comment_count: -1)
  end

end
