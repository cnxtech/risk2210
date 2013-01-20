class TurnSerializer < ActiveModel::Serializer

  attributes :id, :order, :year, :game_player_id, :game_id

  has_many :game_player_stats

end
