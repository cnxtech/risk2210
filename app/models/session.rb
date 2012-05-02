class Session
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Conversion
  include ActiveModel::Validations
    
  attr_accessor :email, :password, :remember_me
  
  validates_presence_of :email
  validates_presence_of :password

  def initialize(attributes = {})  
     attributes.each do |name, value|  
       public_send("#{name}=", value)  
     end  
   end 
    
  def persisted?
    false
  end
  
  def authenticated?
    return false unless valid?
    @player = Player.where(email: email).first
    if @player && @player.password_digest && @player.authenticate(password)
      return true
    else
      return false
    end
  end
  
  def player
    @player
  end

end