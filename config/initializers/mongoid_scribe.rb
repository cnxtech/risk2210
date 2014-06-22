# Mongoid::Scribe.configure do

#   authenticate_with :admin_required

#   mount_at "/admin/documents"

#   form_configuration_for Player do
#     field :first_name
#     field :last_name
#     field :handle
#     field :city
#     field :state
#     field :zip_code
#     field :website
#     field :bio, type: :textarea
#     field :favorite_color, values: GamePlayer::COLORS
#     field :email, type: :email
#     field :admin
#   end

#   form_configuration_for Game do
#     field :location
#     field :notes, type: :textarea
#     field :map_ids, label: :name
#   end

#   form_configuration_for GamePlayer do
#     field :color, values: GamePlayer::COLORS
#     field :territory_count
#     field :energy
#     field :units
#     field :handle
#     field :turn_order
#     field :colony_influence
#     field :space_stations
#     field :starting_territory_count
#     field :player_id, label: :handle
#     field :faction_id
#   end

#   form_configuration_for GamePlayerStat do
#     field :units
#     field :energy
#     field :territory_count
#     field :space_stations
#     field :continent_ids, label: :name, values: ->(game_player_stat) { game_player_stat.game_player.game.maps.collect(&:continents).flatten.sort_by(&:name) }
#   end

#   form_configuration_for Turn do
#     field :game_player_id, label: :handle, values: ->(turn) { turn.game.game_players.all }
#     field :order
#     field :year
#   end

#   form_configuration_for Continent do
#     field :name
#     field :type, values: Continent::TYPES
#     field :color
#     field :bonus
#     field :map_id, label: :name
#   end

#   index_configuration_for Player do
#     column :handle
#     column :email, value: ->(player) { "<a href='mailto:#{player.email}'>#{player.email}</a>".html_safe }
#     column :favorite_color, value: ->(player) { "<span style='color: #{GamePlayer.hex_color(player.favorite_color)}'>#{player.favorite_color}</span>".html_safe }
#   end

#   index_configuration_for Game do
#     column :player, value: ->(game) { game.creator.handle }
#     column :location
#     column :created_at
#   end

#   index_configuration_for Comment do
#     column :player, value: ->(comment) { comment.player.handle }
#     column :created_at
#     column :body
#   end

#   index_configuration_for Map do
#     column :name
#     column :moon, value: ->(map) { map.moon?.yes_or_no }
#   end

#   index_configuration_for Continent do
#     column :name
#     column :type
#     column :bonus
#     column :color, value: ->(continent) { "<span style='color: #{continent.color}'>#{continent.color}</span>".html_safe }
#   end

#   index_configuration_for Forum do
#     column :name
#     column :description
#   end

#   index_configuration_for Topic do
#     column :subject
#     column :view_count
#     column :comment_count
#     column :created_at
#     column :last_comment_at
#   end

#   index_configuration_for Faction do
#     column :name
#     column :classification
#     column :abilities
#     column :starting_resources, value: ->(faction) { faction.starting_resources.join("<br />").html_safe }
#     column :official, value: ->(faction) { faction.official?.yes_or_no }
#     column :space_stations
#   end

# end
