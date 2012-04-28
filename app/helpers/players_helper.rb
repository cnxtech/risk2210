module PlayersHelper
  
  def us_states_options
    States::STATES
  end

  def location(player)
    player.location
  end

  def avatar(player, options={})
    size = options[:size] || :large
    image_path = player.profile_image_path(size)
    if size == :large
      size = 150
    else
      size = 50
    end
    return image_tag(image_path, width: "#{size}px;")
  end
  
end
