class TurnSerializer < ActiveModel::Serializer

  attributes :id, :order, :units_collected, :energy_collected, :territories_held, :continent_ids, :game_id

end
