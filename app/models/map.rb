class Map
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String
  field :moon, type: Boolean, default: false

  slug :name
  
  attr_accessible :name, :moon


end
