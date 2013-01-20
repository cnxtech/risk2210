class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :location, type: String
  field :number_of_years, type: Integer, default: 5
  field :notes, type: String
  field :current_year, type: Integer, default: 1

  has_and_belongs_to_many :maps
  has_many :game_players, autosave: true, dependent: :destroy
  has_many :turns
  belongs_to :creator, class_name: "Player"

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

  private

  def number_of_players
    errors.add(:base, "You must have at least two players.") if game_players.size < 2
    errors.add(:base, "You can't have more than five players.") if game_players.size > 5
  end

  def number_of_maps
    errors.add(:base, "You must choose one or more maps to play.") if maps.size < 1
  end

  def starting_turn_positions
    starting_turn_orders = game_players.map(&:starting_turn_order).uniq
    errors.add(:base, "Every player must have a unique starting turn order.") if starting_turn_orders.size != game_players.size
  end

end
