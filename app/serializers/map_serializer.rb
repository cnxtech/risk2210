class MapSerializer < ActiveModel::Serializer

  attributes :id, :name

  has_many :continents

end
