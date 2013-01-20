class GamePlayerStatSerializer < ActiveModel::Serializer

  attributes :id, :units, :energy, :territory_count, :turn_id, :continent_ids

end
