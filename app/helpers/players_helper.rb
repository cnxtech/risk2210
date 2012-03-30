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
  
end
