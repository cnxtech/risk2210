# Mongoid.models

Mongoid::DocumentEditor.configure do

  authenticate_with :admin_required

  form_configuration_for Player do
    field :first_name
    field :favorite_color, values: GamePlayer::COLORS
    field :email, type: :email
  end

  form_configuration_for Game do
    field :location
    field :notes, type: :text
    field :map_ids, values: -> { Map.all }, label: :name, value: :id
  end

  form_configuration_for GamePlayer do
    field :color, values: GamePlayer::COLORS
    field :territory_count
    field :energy
    field :units
    field :handle
    field :turn_order
    field :colony_influence
    field :space_stations
    field :starting_territory_count
    field :player_id, values: -> { Player.all }, label: :handle, value: :id
    field :faction_id, values: -> { Faction.all }, label: :name, value: :id
  end

  form_configuration_for GamePlayerStat do
    field :continent_ids, values: ->(game_player_stat) { game_player_stat.game_player.game.maps.collect(&:continents).flatten }, label: :name, value: :id
  end

  index_configuration_for Player do
    column :handle
    column :email
    column :favorite_color
  end

end
