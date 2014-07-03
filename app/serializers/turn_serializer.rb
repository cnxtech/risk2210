class TurnSerializer < ActiveModel::Serializer
  include SerializableId

  attributes :id,
             :order,
             :year,
             :game_player_id,
             :game_id

  has_many :game_player_stats

  def game_player_id
    object.game_player_id.to_s
  end

  def game_id
    object.game_id.to_s
  end

end
