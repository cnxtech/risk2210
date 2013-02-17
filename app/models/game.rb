class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :location,        type: String
  field :number_of_years, type: Integer, default: 5
  field :notes,           type: String
  field :current_year,    type: Integer, default: 1
  field :completed,       type: Boolean, default: false

  has_and_belongs_to_many :maps
  has_many :game_players, autosave: true, dependent: :destroy
  has_many :turns
  belongs_to :creator, class_name: "Player"
  belongs_to :current_player, class_name: "GamePlayer"

  before_create :set_current_player

  accepts_nested_attributes_for :game_players, allow_destroy: true

  validate :number_of_players
  validate :number_of_maps
  validate :starting_turn_positions

  def has_map?(map)
    map_ids.include?(map.id)
  end

  def map_names
    maps.collect(&:name).to_sentence
  end

  def percent_complete
    (turn_count.to_f / (number_of_years * game_players.count).to_f) * 100
  end

  def turn_count
    turns.count
  end

  def start_year(turn_order)
    self.current_year = self.current_year + 1
    game_players.each do |game_player|
      game_player.turn_order = turn_order[game_player.id.to_s]
      self.current_player = game_player if turn_order[game_player.id.to_s] == "1"
    end
    self.save
  end

  def end_game(colony_influence)
    self.completed = true
    game_players.each do |game_player|
      game_player.colony_influence = colony_influence[game_player.id.to_s]
    end
    self.save
  end

private

  def number_of_players
    errors.add(:base, "You must have at least two players.") if game_players.size < 2
    errors.add(:base, "You can't have more than five players.") if game_players.size > 5
  end

  def number_of_maps
    errors.add(:base, "You must choose one or more maps to play.") if maps.size < 1
  end

  def starting_turn_positions
    turn_orders = game_players.map(&:turn_order).uniq
    errors.add(:base, "Every player must have a unique starting turn order.") if turn_orders.size != game_players.size
  end

  def set_current_player
    self.current_player = game_players.detect{|game_player| game_player.turn_order == 1}
  end

end
