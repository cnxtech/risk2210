class GameSerializer < ActiveModel::Serializer

  attributes :id, :turn_count, :number_of_years, :current_year

  has_many :game_players
  has_many :maps
  has_many :turns

end
