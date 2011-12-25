class Forum
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  field :description, type: String

  slug :name
  
  has_many :topics
  
end
