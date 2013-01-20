class Turn
  include Mongoid::Document
  include Mongoid::Timestamps

  field :order, type: Integer, default: 1
  field :year, type: Integer, default: 1

  belongs_to :game_player
  belongs_to :game
  has_many :game_player_stats, dependent: :destroy

  validates_presence_of :game_player_id

  accepts_nested_attributes_for :game_player_stats

end
