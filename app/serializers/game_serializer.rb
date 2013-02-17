class GameSerializer < ActiveModel::Serializer

  attributes :id, :turn_count, :number_of_years, :current_year, :current_player_id

  has_many :game_players
  has_many :maps
  has_many :turns

end
