class Map
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String
  field :moon, type: Boolean, default: false

  has_and_belongs_to_many :games, index: true
  has_many :continents, dependent: :destroy

  slug :name

  index slug: 1

  scope :alphabetical, ->() { asc(:name) }

end
