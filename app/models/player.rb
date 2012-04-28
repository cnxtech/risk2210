require 'better_secure_password'

class Player
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include ActiveModel::SecurePasswordBetter

  IMAGE_SOURCES = %w(Facebook Gravatar)
  
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

  ## Associations
  has_many :topics, dependent: :destroy, autosave: true
  has_many :comments, dependent: :destroy, autosave: true
  has_many :game_players
  has_many :games, as: :creator
  
  ## Plugins
  slug :handle
  has_secure_password

  attr_accessible :email, :first_name, :last_name, :handle, :city, :state, :zip_code, :bio, :website, :image_source, :public_profile, :password, :password_confirmation, :old_password

  ## Callbacks
  before_save :generate_gravatar_hash, if: :email_changed?
  after_create :deliver_welcome_email

  ## Validations
  validates_presence_of :email, :handle
  validates_uniqueness_of :email, :handle
  validates_inclusion_of :image_source, in: IMAGE_SOURCES, allow_blank: true
  validates_format_of :email, with: EmailAddressValidation::EMAIL_ADDRESS_EXACT_PATTERN, allow_blank: true

  ## Scopes
  scope :public_profiles, where(public_profile: true)
  
  def full_name
    return handle if handle.present?
    return first_name if first_name.present?
    return email
  end
  
  def self.omniauthorize(auth)
    Player.where(provider: auth['provider'], uid: auth['uid']).first || self.create_with_omniauth(auth)
  end

  ## Facebook image size options
  ## square=50x50, small=50xVariable, normal=100xVariable, large=200xVariable

  def profile_image_path(size=:normal)
    if image_source == "Facebook" && facebook_image_url
      return facebook_image_url + "?type=#{size}"
    elsif image_source == "Gravatar"
      gravatar_size = case size
        when :square, :small ; 50
        when :normal ; 100
        when :large ; 200
      end
      return "http://www.gravatar.com/avatar/#{gravatar_hash}?size=#{gravatar_size}"
    else
      return nil
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

  def as_json(options={})
    super(only: [:id, :first_name, :last_name, :email, :bio, :handle, :city, :state, :zip_code, :slug, :website], methods: [:profile_image_path])
  end
  
  private
  
  def self.create_with_omniauth(auth)
    player = Player.where(email: auth['info']['email']).first
    if player
      player.facebook_image_url = sanitize_facebook_image(auth["info"]["image"])
      player.provider = auth['provider']
      player.uid = auth['uid']
    else
      player = Player.new
      player.provider = auth['provider']
      player.uid = auth['uid']
      if auth['info']
         player.first_name = auth['info']['first_name'] || ""
         player.last_name = auth['info']['last_name'] || ""
         player.email = auth['info']['email'] || ""
         player.handle = auth['info']['nickname'] || ""
         player.website = auth["info"]["urls"]["Facebook"]
         player.facebook_image_url = sanitize_facebook_image(auth["info"]["image"])
         location = auth["extra"]["raw_info"]["location"]["name"].split(",")
         player.city = location[0].strip
         player.state = States.decode(location[1])
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

  def generate_remember_me_token
    remember_me_token = SecureRandom.hex(8)
  end

  def deliver_welcome_email
    #PlayerMailer.welcome_email(self).deliver
  end

end


# --- !ruby/hash:OmniAuth::AuthHash
# provider: facebook
# uid: '753509698'
# info: !ruby/hash:OmniAuth::AuthHash::InfoHash
#   nickname: nick.desteffen
#   email: nick.desteffen@gmail.com
#   name: Nick DeSteffen
#   first_name: Nick
#   last_name: DeSteffen
#   image: http://graph.facebook.com/753509698/picture?type=square
#   urls: !ruby/hash:Hashie::Mash
#     Facebook: http://www.facebook.com/nick.desteffen
#   location: Chicago, Illinois
# credentials: !ruby/hash:Hashie::Mash
#   token: AAADMjLRob70BAAUV32EicRHN3owCqrySC3w5K847rCgpkGZBQL1VHZA4ARJG9ECg9DQ3fFETgnz0pGyi8LKZCbWgZAts1lQZD
#   expires: false
# extra: !ruby/hash:Hashie::Mash
#   raw_info: !ruby/hash:Hashie::Mash
#     id: '753509698'
#     name: Nick DeSteffen
#     first_name: Nick
#     last_name: DeSteffen
#     link: http://www.facebook.com/nick.desteffen
#     username: nick.desteffen
#     location: !ruby/hash:Hashie::Mash
#       id: '108659242498155'
#       name: Chicago, Illinois
#     gender: male
#     email: nick.desteffen@gmail.com
#     timezone: -6
#     locale: en_US
#     verified: true
#     updated_time: '2011-10-23T20:08:53+0000'
