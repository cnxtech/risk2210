module FactionsHelper
  
  def faction_card_image(faction)
    image_tag("faction_cards/#{faction.name.downcase.gsub(' ', '_')}.jpg")
  end
  
end
