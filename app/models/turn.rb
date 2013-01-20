class Turn
  include Mongoid::Document
  include Mongoid::Timestamps

  field :order, type: Integer, default: 1
  field :year, type: Integer, default: 1

  belongs_to :game_player
  belongs_to :game
  has_many :game_player_stats, dependent: :destroy

  after_create :update_game_year

  validates_presence_of :game_player_id, :order, :year

  accepts_nested_attributes_for :game_player_stats

  def last?
    game.game_players.size == order
  end

private

  def update_game_year
    game.inc(:current_year, 1) if last?
  end

end
