class GamePlayer
  include Mongoid::Document
  include Mongoid::Timestamps

  COLORS = %w(Green Blue Red Black Gold)

  field :color, type: String

  belongs_to :game
  belongs_to :player
  belongs_to :faction
  has_many :turns

  delegate :handle, to: :player

  validates_inclusion_of :color, in: COLORS
  
end
