module PlayersHelper
  
  def us_states_options
    States::STATES
  end

  def location(player)
    address = ""
    if player.city.present? && player.state.present?
      address = player.city + ", " + player.state
    end
    if player.zip_code.present?
      address = address + " " + player.zip_code
    end
    if address.present?
      return address
    else
      return "Unknown"
    end
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
