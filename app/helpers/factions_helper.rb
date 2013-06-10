module FactionsHelper

  def faction_card_image(faction)
    return if faction.default?
    image_tag("faction_cards/#{faction.image_name_format}.jpg", alt: faction.name)
  end

  def faction_icon(faction, size=50)
    return if faction.default?
    image_tag("faction_icons/#{faction.image_name_format}.png", alt: faction.name, width: size)
  end

end
