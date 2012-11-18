class GamePlayerSerializer < ActiveModel::Serializer

  attributes :color, :territory_count, :energy, :units, :id, :continent_ids, :handle, :profile_image_path

  has_one :player
  has_one :faction
  has_many :turns

end
