class GamePlayerSerializer < ActiveModel::Serializer

  attributes :color, :territory_count, :energy, :units, :id, :continent_ids, :handle, :profile_image_path, :turn_order, :space_stations

  has_one :player
  has_one :faction

end
