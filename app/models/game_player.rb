class GamePlayer
  include Mongoid::Document
  include Mongoid::Timestamps

  COLORS = %w(Green Blue Red Black Gold)

  field :color,                  type: String
  field :territory_count,        type: Integer
  field :energy,                 type: Integer
  field :units,                  type: Integer
  field :handle,                 type: String
  field :starting_turn_position, type: Integer

  belongs_to :game
  belongs_to :player
  belongs_to :faction
  has_many :turns, dependent: :destroy
  has_and_belongs_to_many :continents
  has_many :game_player_stats

  before_create :set_starting_resources

  validates_inclusion_of :color, in: COLORS
  validates_presence_of :faction_id, :handle
  validates_numericality_of :starting_turn_position, greater_than_or_equal_to: 1, less_than_or_equal_to: 5

  def handle=(value)
    write_attribute(:handle, value)
    if player = Player.find(value.to_url)
      self.player = player
    end
  end

  def profile_image_path
    return player.profile_image_path if player
    return "http://risk2210.net/assets/default_avatar.png"
  end

  private

  def set_starting_resources
    self.territory_count ||= 0
    self.energy = faction.min_energy
    self.units = faction.min_units
  end

end
