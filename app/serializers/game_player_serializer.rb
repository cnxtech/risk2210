class GamePlayerSerializer < ActiveModel::Serializer
  include SerializableId

  attributes :color,
             :territory_count,
             :energy,
             :units,
             :id,
             :continent_ids,
             :handle,
             :profile_image_path,
             :turn_order,
             :space_stations

  has_one :player
  has_one :faction

  def continent_ids
    object.continent_ids.map(&:to_s)
  end

end
