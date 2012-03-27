class Map
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String
  field :moon, type: Boolean, default: false

  has_and_belongs_to_many :games

  slug :name
  
  attr_accessible :name, :moon


end
