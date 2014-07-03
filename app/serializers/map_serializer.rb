class MapSerializer < ActiveModel::Serializer
  include SerializableId

  attributes :id,
             :name

  has_many :continents

end
