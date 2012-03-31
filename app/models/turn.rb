class Turn
  include Mongoid::Document
  include Mongoid::Timestamps

  field :order, type: Integer, default: 1
  field :units_collected, type: Integer, default: 3
  field :energy_collected, type: Integer, default: 3
  field :territories_held, type: Integer

  attr_accessible :energy_collected, :units_collected, :game_player_id, :territories_held

  belongs_to :game_player
  belongs_to :game

end
