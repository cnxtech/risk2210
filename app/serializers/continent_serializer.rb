class ContinentSerializer < ActiveModel::Serializer
  include SerializableId

  attributes :id,
             :name,
             :type,
             :bonus,
             :color

end
