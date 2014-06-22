class Continent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  TYPES = ["Land", "Water", "Lunar"]

  field :name,  type: String
  field :type,  type: String
  field :bonus, type: Integer
  field :color, type: String

  index name: 1, type: 1

  slug :name

  belongs_to :map, index: true

  scope :ordered, ->() { order_by(type: "asc").order_by(name: "asc") }

  validates_presence_of :name, :type, :bonus, :color

end
