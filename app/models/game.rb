class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :location, type: String
  field :number_of_years, type: Integer, default: 5
  field :notes, type: String

  attr_accessible :location , :notes, :map_ids, :game_players_attributes, :number_of_years
  
  has_and_belongs_to_many :maps
  has_many :game_players, autosave: true, dependent: :destroy
  has_many :turns
  belongs_to :creator, class_name: "Player"
    
  accepts_nested_attributes_for :game_players, allow_destroy: true

  validate :number_of_players
  validate :number_of_maps
  
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

  def as_json(options={})
    options = {
      methods: [:id, :turn_count],
      only: [:number_of_years],
      include: {
        game_players: {
          only: [:color, :territory_count, :energy, :units],
          methods: [:id, :continent_ids],
          include: {
            player: {only: [:handle, :first_name, :last_name, :email], methods: [:profile_image_path]},
            faction: {only: [:name, :abilities, :classification, :starting_resources]},
            turns: {only: [:order, :units_collected, :energy_collected, :territories_held]}
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
