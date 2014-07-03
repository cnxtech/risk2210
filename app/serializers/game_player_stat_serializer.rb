class GamePlayerStatSerializer < ActiveModel::Serializer
  include SerializableId

  attributes :id,
             :units,
             :energy,
             :territory_count,
             :turn_id,
             :continent_ids,
             :space_stations,
             :game_player_id

  def game_player_id
    object.game_player_id.to_s
  end

  def continent_ids
    object.continent_ids.map(&:to_s)
  end

end
