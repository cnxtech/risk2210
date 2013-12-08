class GamePlayerStatSerializer < ActiveModel::Serializer

  attributes :id, :units, :energy, :territory_count, :turn_id, :continent_ids, :space_stations, :game_player_id

end
