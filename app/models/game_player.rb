class GamePlayer
  include Mongoid::Document
  include Mongoid::Timestamps

  COLORS = %w(Green Blue Red Black Gold)

  field :color, type: String
  field :territory_count, type: Integer
  field :energy, type: Integer
  field :units, type: Integer

  attr_accessible :color, :territory_count, :energy, :units, :faction_id, :player_id, :continent_ids

  belongs_to :game
  belongs_to :player
  belongs_to :faction
  has_many :turns
  has_and_belongs_to_many :continents

  before_create :set_starting_resources

  delegate :handle, to: :player

  validates_inclusion_of :color, in: COLORS
  validates_presence_of :faction_id, :player_id
  
  private

  def set_starting_resources
    self.territory_count ||= 0
    self.energy = faction.min_energy
    self.units = faction.min_units
  end

end
