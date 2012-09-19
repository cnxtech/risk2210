module FactionsHelper
  
  def faction_card_image(faction)
    image_tag("faction_cards/#{faction.image_name_format}.jpg", alt: faction.name)
  end

  def faction_icon(faction, size=50)
    image_tag("faction_icons/#{faction.image_name_format}.png", alt: faction.name, width: size)
  end
  
end
