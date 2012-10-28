module PlayersHelper
  
  def us_states_options
    States::STATES
  end

  def avatar(player, options={})
    size = options.fetch(:size, :large)
    image_path = player.profile_image_path(size)

    pixels = size == :large ? 150 : 50
    return image_tag(image_path, width: "#{pixels}px;", alt: player.handle)
  end
  
end
