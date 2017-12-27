## Turn
json.id(String(turn.id))
json.game_player_id(String(turn.game_player_id))
json.game_id(String(turn.game_id))
json.(turn,
  :order,
  :year
)

## GamePlayerStats
json.game_player_stats(turn.game_player_stats) do |game_player_stat|
  json.id(String(game_player_stat.id))
  json.game_player_id(String(game_player_stat.game_player_id))
  json.continent_ids(game_player_stat.continent_ids.map(&:to_s))
  json.turn_id(String(game_player_stat.turn_id))
  json.(game_player_stat,
    :units,
    :energy,
    :territory_count,
    :space_stations
  )
end
