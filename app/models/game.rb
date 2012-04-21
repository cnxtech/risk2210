class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :location, type: String
  field :number_of_years, type: Integer, default: 5
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
    maps.collect(&:name).to_sentence
  end

  def percent_complete
    (turns.count.to_f / (number_of_years * game_players.count).to_f) * 100
  end

  def years
    turns / game_players.count
  end

  def turn_count
    turns.count
  end

  def as_json(options={})
    options = {
      methods: [:id, :turn_count],
      only: [:number_of_years],
      include: {
        game_players: {
          only: [:color],
          methods: [:id],
          include: {
            player: {only: [:handle, :first_name, :last_name, :email], methods: [:profile_image_path]},
            faction: {only: [:name]}
          }
        },
        maps:{
          only: [:name],
          methods: [:id],
          include: {
            continents: {only: [:name, :type, :bonus, :color], methods: [:id]}
          }
        }
      }
    }
    super(options)
  end

  private
  
  def number_of_players
    errors.add(:base, "You must have at least two players.") if game_players.size < 2
  end
  
  def number_of_maps
    errors.add(:base, "You must choose one or more maps to play.") if maps.size < 1
  end

end
