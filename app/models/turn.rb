class Turn
  include Mongoid::Document
  include Mongoid::Timestamps

  field :order, type: Integer, default: 1
  field :units_collected, type: Integer, default: 3
  field :energy_collected, type: Integer, default: 3

  belongs_to :game_player

end
