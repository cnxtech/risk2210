class Topic
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :subject, type: String
  field :view_count, type: Integer, default: 1
  field :comment_count, type: Integer, default: 0
  field :last_comment_at, type: DateTime

  slug :subject

  belongs_to :player, index: true
  belongs_to :forum, index: true
  has_many :comments, as: :commentable, dependent: :destroy, autosave: true

  validates_presence_of :subject

  accepts_nested_attributes_for :comments

  def increment_view_counter
    inc(view_count: 1)
  end

  def commentable_label
    "Topic - #{comments.first.body.truncate(30)}"
  end

end
