class Continent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  TYPES = ["Land", "Water", "Lunar"]

  field :name, type: String
  field :type, type: String
  field :bonus, type: Integer
  field :color, type: String

  slug :name

  belongs_to :map

  scope :ordered, order_by(type: "asc").order_by(name: "asc")

end
