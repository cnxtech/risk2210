module Authentication
  class Risk2210
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

    def authenticate
      return nil unless valid?
      if player && player.valid_password?(password)
        player.set_login_stats
        player.remember_me_token = SecureRandom.hex(8)
        player.save
        return player
      end
      return nil
    end

private

    def player
      @player ||= Player.where(email: email).first
    end

  end
end
