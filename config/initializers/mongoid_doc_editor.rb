Mongoid::DocumentEditor.configure do

  authenticate_with :admin_required

  mount_at "/admin/documents"

  form_configuration_for Player do
    field :first_name
    field :last_name
    field :handle
    field :city
    field :state
    field :zip_code
    field :website
    field :bio, type: :text
    field :favorite_color, values: GamePlayer::COLORS
    field :email, type: :email
    field :admin
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

  index_configuration_for Game do
    column :player, value: ->(game) { game.creator.handle }
    column :location
    column :created_at
  end

  index_configuration_for Comment do
    column :player, value: ->(comment) { comment.player.handle }
    column :created_at
    column :body
  end

  index_configuration_for Map do
    column :name
    column :moon, value: ->(map) { map.moon?.yes_or_no }
  end

  index_configuration_for Continent do
    column :name
    column :type
    column :bonus
    column :color, value: ->(continent) { "<span style='color: #{continent.color}'>#{continent.color}</span>".html_safe }
  end

  index_configuration_for Forum do
    column :name
    column :description
  end

  index_configuration_for Topic do
    column :subject
    column :view_count
    column :comment_count
    column :created_at
    column :last_comment_at
  end

  index_configuration_for Faction do
    column :name
    column :classification
    column :abilities
    column :starting_resources, value: ->(faction) { faction.starting_resources.join("<br />").html_safe }
    column :official, value: ->(faction) { faction.official?.yes_or_no }
    column :space_stations
  end

end
