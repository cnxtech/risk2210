class Faction
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  field :classification, type: String
  field :abilities, type: String
  field :starting_resources, type: String
  field :official, type: Boolean, default: true

  has_many :game_players

  slug :name
  
  attr_accessible :name, :classification, :starting_resources, :abilities, :official
  
  validates_presence_of :name, :classification, :starting_resources, :abilities

  scope :non_default, ne(name: "Default")
  
  def starting_resources
    read_attribute(:starting_resources).split("\n")
  end

  def self.random
    Faction.all.sample(1).first
  end

  def fusion_conservancy?
    name == "The Fusion Conservancy"
  end

  def mega_corp?
    name == "MegaCorp"
  end

  def min_energy
    return 4 if fusion_conservancy?
    return 3
  end

  def min_units
    return 4 if mega_corp?
    return 3
  end

  def image_name_format
    name.downcase.split(" ").join("_")
  end
    
end
