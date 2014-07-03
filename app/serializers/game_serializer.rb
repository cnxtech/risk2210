class GameSerializer < ActiveModel::Serializer
  include SerializableId

  attributes :id,
             :turn_count,
             :number_of_years,
             :current_year,
             :current_player_id

  has_many :game_players
  has_many :maps
  has_many :turns

  def current_player_id
    object.current_player_id.to_s
  end

end
