class Turn
  include Mongoid::Document
  include Mongoid::Timestamps

  field :order, type: Integer, default: 1
  field :year,  type: Integer, default: 1

  belongs_to :game_player, index: true
  belongs_to :game, index: true
  has_many :game_player_stats, dependent: :destroy

  after_create :set_current_player

  validates_presence_of :game_player_id, :order, :year

  accepts_nested_attributes_for :game_player_stats

private

  def set_current_player
    next_player = game.game_players.where(turn_order: order + 1).first
    game.current_player = next_player
    game.save
  end

end
