class Player
  require 'bcrypt'

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  module ImageSource
    Facebook = "Facebook"
    Gravatar = "Gravatar"
  end
  
  ## Field Definitions
  field :provider, type: String
  field :uid, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :handle, type: String
  field :city, type: String
  field :state, type: String
  field :zip_code, type: String
  field :bio, type: String
  field :website, type: String
  field :facebook_image_url, type: String
  field :image_source, type: String
  field :gravatar_hash, type: String
  field :public_profile, type: Boolean, default: true
  field :password_digest, type: String
  field :remember_me_token, type: String
  field :raw_authorization, type: Hash
  field :login_count, type: Integer, default: 1
  field :last_login_at, type: DateTime, default: -> { Time.now }

  ## Associations
  has_many :topics, dependent: :destroy, autosave: true
  has_many :comments, dependent: :destroy, autosave: true
  has_many :game_players
  has_many :games, as: :creator
  
  ## Plugins
  slug :handle
  
  attr_reader :password

  attr_accessible :email, :first_name, :last_name, :handle, :city, :state, :zip_code, :bio, :website, :image_source, :public_profile, :password, :password_confirmation, :old_password

  ## Callbacks
  before_save :generate_gravatar_hash, if: :email_changed?
  after_create :deliver_welcome_email

  ## Validations
  validates_presence_of :email, :handle
  validates_uniqueness_of :email, :handle
  validates_inclusion_of :image_source, in: [ImageSource::Facebook, ImageSource::Gravatar], allow_blank: true
  validates_format_of :email, with: EmailAddressValidation::EMAIL_ADDRESS_EXACT_PATTERN, allow_blank: true
  validates_confirmation_of :password
  validates_presence_of :password_digest, allow_blank: true

  ## Scopes
  scope :public_profiles, where(public_profile: true).asc(:created_at)
  
  def full_name
    return handle if handle.present?
    return first_name if first_name.present?
    return email
  end
  
  def self.omniauthorize(auth)
    player = Player.where(provider: auth['provider'], uid: auth['uid']).first || self.create_with_omniauth(auth)
    player.set_login_stats
    player.save
    return player
  end

  ## Facebook image size options
  ## square=50x50, small=50xVariable, normal=100xVariable, large=200xVariable

  def profile_image_path(size=:normal)
    default_avatar_path = "http://risk2210.net/assets/default_avatar.png"
    if image_source == ImageSource::Facebook && facebook_image_url
      return facebook_image_url + "?type=#{size}"
    elsif image_source == ImageSource::Gravatar
      gravatar_size = case size
        when :square, :small ; 50
        when :normal ; 100
        when :large ; 200
      end
      return "http://www.gravatar.com/avatar/#{gravatar_hash}?size=#{gravatar_size}&default=#{CGI::escape(default_avatar_path)}"
    else
      return default_avatar_path
    end
  end

  def change_password(password_attributes={})
    if password_digest.present? && !authenticate(password_attributes.delete(:old_password))
      errors.add(:base, "Old password doesn't match") 
      return false
    else
      return update_attributes(password_attributes)
    end
  end

  def nearby_players
    Player.public_profiles
  end

  def location
    address = ""
    if city.present? && state.present?
      address = city + ", " + state
    end
    if zip_code.present?
      address = address + " " + zip_code
    end
    return address
  end

  def as_json(options={})
    options.merge!({
      only: [:id, :first_name, :last_name, :email, :bio, :handle, :city, :state, :zip_code, :slug, :website], 
      methods: [:profile_image_path]
    })
    super(options)
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(password_digest) == unencrypted_password
      set_login_stats
      set_remember_me_token
      save
      return true
    else
      return false
    end
  end

  def set_login_stats
    self.login_count = self.login_count + 1
    self.last_login_at = Time.now
  end
  
  private
  
  def self.create_with_omniauth(auth)
    player = Player.where(email: auth['info']['email']).first
    if player
      player.facebook_image_url = sanitize_facebook_image(auth["info"]["image"])
      player.provider = auth['provider']
      player.uid = auth['uid']
      player.raw_authorization = auth
    else
      player = Player.new
      player.provider = auth['provider']
      player.uid = auth['uid']
      player.raw_authorization = auth
      if auth['info']
        player.first_name = auth['info']['first_name'] || ""
        player.last_name = auth['info']['last_name'] || ""
        player.email = auth['info']['email'] || ""
        player.handle = auth['info']['nickname'] || ""
        player.website = auth["info"]["urls"]["Facebook"]
        player.facebook_image_url = sanitize_facebook_image(auth["info"]["image"])
        player.image_source = ImageSource::Facebook
        
        if auth["extra"]["raw_info"]["location"]
          location_parts = auth["extra"]["raw_info"]["location"]["name"].split(",")
        elsif auth["extra"]["raw_info"]["hometown"]
          location_parts = auth["extra"]["raw_info"]["hometown"]["name"].split(",")
        end
        if location_parts
          player.city = location_parts[0].strip
          player.state = States.decode(location_parts[1]) if location_parts[1]
        end
      end
    end
    player.save
    return player
  end

  def self.sanitize_facebook_image(facebook_image_url)
    return "" if facebook_image_url.strip.blank?
    return facebook_image_url.gsub("?type=square", "")
  end

  def generate_gravatar_hash
    if email.present?
      hash = Digest::MD5.hexdigest(email)
      write_attribute(:gravatar_hash, hash)
    end
  end

  def set_remember_me_token
    self.remember_me_token = SecureRandom.hex(8)
  end

  def deliver_welcome_email
    #PlayerMailer.welcome_email(self).deliver
  end

end
