class GameSerializer < ActiveModel::Serializer

  attributes :id, :turn_count, :number_of_years

  has_many :game_players
  has_many :maps

end
