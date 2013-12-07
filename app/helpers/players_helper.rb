module PlayersHelper

  def us_states_options
    States::STATES
  end

  def avatar(player, size: :large)
    image_path = player.profile_image_path(size)

    pixels = size == :large ? 150 : 50
    return image_tag(image_path, width: "#{pixels}px;", alt: player.handle)
  end

  def nearby_players
    return if current_player.nil? || current_player.location.blank?
    nearby_players = Player.near(current_player.location, 50)
    return if nearby_players.empty?
    render partial: "players/nearby_players", locals: {nearby_players: nearby_players}
  end

end
