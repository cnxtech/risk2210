class Player
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :first_name, :type => String
  field :last_name, :type => String
  field :email, :type => String
  
  attr_accessible :email, :first_name, :last_name#, :handle, :city, :state, :zip_code, :bio, :website
  
end
