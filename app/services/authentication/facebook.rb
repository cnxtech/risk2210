module Authentication
  class Facebook

    def initialize(auth)
      @auth = auth
    end

    def authenticate
      player = Player.where(provider: @auth['provider'], uid: @auth['uid']).first || create_with_omniauth
      player.set_login_stats
      player.save
      return player
    end

private

    def create_with_omniauth
      player = Player.where(email: @auth['info']['email']).first
      if player
        player.facebook_image_url   = sanitized_facebook_image
        player.provider             = @auth['provider']
        player.uid                  = @auth['uid']
        player.raw_authorization    = @auth
      else
        player = Player.new
        player.provider             = @auth['provider']
        player.uid                  = @auth['uid']
        player.raw_authorization    = @auth
        if @auth['info']
          player.first_name         = @auth['info']['first_name'] || ""
          player.last_name          = @auth['info']['last_name'] || ""
          player.email              = @auth['info']['email'] || ""
          player.handle             = @auth['info']['nickname'] || ""
          player.website            = @auth["info"]["urls"]["Facebook"]
          player.facebook_image_url = sanitized_facebook_image
          player.image_source       = Player::ImageSource::Facebook

          if @auth["extra"]["raw_info"]["location"]
            location_parts = @auth["extra"]["raw_info"]["location"]["name"].split(",")
          elsif @auth["extra"]["raw_info"]["hometown"]
            location_parts = @auth["extra"]["raw_info"]["hometown"]["name"].split(",")
          end
          if location_parts
            player.city  = location_parts[0].strip
            player.state = States.decode(location_parts[1]) if location_parts[1]
          end
        end
      end
      player.save
      return player
    end

    def sanitized_facebook_image
      return "" if @auth["info"]["image"].strip.blank?
      return @auth["info"]["image"].gsub("?type=square", "")
    end

  end
end
