class Forum
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  field :description, type: String

  slug :name
  
  has_many :topics

  validates_presence_of :name, :description
  validates_uniqueness_of :name
    
end
