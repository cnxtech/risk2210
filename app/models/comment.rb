class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String

  attr_accessible :body

  belongs_to :player
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates_presence_of :body

end
