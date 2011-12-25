class Topic
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :subject, type: String
  field :view_count, type: Integer, default: 1

  slug :subject
  
  belongs_to :player
  belongs_to :forum
  has_many :comments, as: :commentable, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :comments
  
  def increment_view_counter
    update_attribute(:view_count, self.view_count + 1)
  end
  
end
