class Faction
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :classification, type: String
  field :abilities, type: String
  field :starting_resources, type: String
  field :official, type: Boolean, default: true
  field :slug, type: String
  
  before_save :set_slug
  
  attr_accessible :name, :classification, :starting_resources, :abilities, :official
  
  validates_presence_of :name, :classification, :starting_resources, :abilities
  
  def to_param
    slug
  end

  def starting_resources
    read_attribute(:starting_resources).split("\n")
  end
  
  private
  
  def set_slug
    write_attribute(:slug, name.downcase.gsub(" ", "-"))
  end
  
end
