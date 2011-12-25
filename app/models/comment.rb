class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String

  belongs_to :player
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
    
end
