## Game
json.id(String(@game.id))
json.current_player_id(String(@game.current_player_id))
json.(@game,
  :turn_count,
  :number_of_years,
  :current_year
)

## GamePlayers
json.game_players(@game.game_players) do |game_player|
  json.id(String(game_player.id))
  json.continent_ids(game_player.continent_ids.map(&:to_s))
  json.(game_player,
    :color,
    :territory_count,
    :energy,
    :units,
    :handle,
    :profile_image_path,
    :turn_order,
    :space_stations
  )

  ## Player
  if game_player.player.present?
    json.player do
      json.id(String(game_player.player.id))
      json.(game_player.player,
        :handle,
        :first_name,
        :last_name,
        :email,
        :bio,
        :city,
        :state,
        :zip_code,
        :slug,
        :website,
        :profile_image_path
      )
    end
  else # Is this needed?
    json.player(nil)
  end

  ## Faction
  json.faction do
    json.id(String(game_player.faction.id))
    json.(game_player.faction,
      :name,
      :abilities,
      :classification,
      :starting_resources,
      :slug
    )
  end
end

## Maps
json.maps(@game.maps) do |map|
  json.id(String(map.id))
  json.(map,
    :name
  )
  json.continents(map.continents) do |continent|
    json.id(String(continent.id))
    json.(continent,
      :name,
      :type,
      :bonus,
      :color
    )
  end
end

## Turns
json.turns @game.turns, partial: 'turns/turn', as: :turn


