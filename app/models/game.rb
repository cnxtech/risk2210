class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :location, type: String
  field :years, type: Integer, default: 5
  field :notes, type: String

  attr_accessible :location, :years, :notes, :map_ids, :game_players_attributes
  
  has_and_belongs_to_many :maps
  has_many :game_players, autosave: true
  has_many :turns, order: "order"
  belongs_to :creator, class_name: "Player"
    
  accepts_nested_attributes_for :game_players

  validate :number_of_players
  validate :number_of_maps
  
  def has_map?(map)
    map_ids.include?(map.id)
  end
  
  def map_names
    maps.collect(&:name).join(", ")
  end
  
  private
  
  def number_of_players
    errors.add(:base, "You must have at least two players.") if game_players.size < 2
  end
  
  def number_of_maps
    errors.add(:base, "You must choose one or more maps to play.") if maps.size < 1
  end

end
