class FactionSerializer < ActiveModel::Serializer
  include SerializableId

  attributes :id,
             :name,
             :abilities,
             :classification,
             :starting_resources,
             :slug

end
