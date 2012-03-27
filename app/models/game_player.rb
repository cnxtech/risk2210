class GamePlayer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :game
  belongs_to :player
  belongs_to :faction
  
end
