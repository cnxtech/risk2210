class Continent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  TYPES = ["Land", "Water", "Lunar", "Lava"]

  field :name, type: String
  field :type, type: String
  field :bonus, type: Integer

  belongs_to :map

end
