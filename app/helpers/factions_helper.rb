module FactionsHelper
  
  def faction_card_image(faction)
    image_tag("faction_cards/#{faction.name.downcase.gsub(' ', '_')}.jpg")
  end

  def faction_icon(faction, size=50)
    image_tag("faction_icons/#{faction.name.downcase.gsub(' ', '_')}.png", width: size)
  end
  
end
