class GamePlayerSerializer < ActiveModel::Serializer

  attributes :color, :territory_count, :energy, :units, :id, :continent_ids, :handle, :profile_image_path, :starting_turn_order

  has_one :player
  has_one :faction

end
