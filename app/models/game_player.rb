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

  def as_json(options={})
    options = {
      only: [:color],
      methods: [:id],
      include: {
        player: {only: [:handle, :first_name, :last_name, :email], methods: [:profile_image_path]},
        faction: {only: [:name]}
      }
    }
    super(options)
  end
  
end
