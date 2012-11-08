class FactionSerializer < ActiveModel::Serializer

  attributes :id, :name, :abilities, :classification, :starting_resources, :slug

end
