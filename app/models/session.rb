class Session
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations
    
  attr_accessor :email, :password
  
  validates_presence_of :email
  validates_presence_of :password

  def initialize(attributes = {})  
     attributes.each do |name, value|  
       send("#{name}=", value)  
     end  
   end 
    
  def persisted?
    false
  end
  
  def authenticated?
    @player = Player.where(email: email).first
    if @player && @player.authenticate(password)
      return true
    else
      return false
    end
  end
  
  def player
    @player
  end
  
end