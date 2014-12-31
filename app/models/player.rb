class Player
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Geocoder::Model::Mongoid

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
  field :favorite_color, type: String
  field :password_reset_token, type: String
  field :admin, type: Boolean, default: false
  field :coordinates, type: Array

  ## Associations
  has_many :topics, dependent: :destroy, autosave: true
  has_many :comments, dependent: :destroy, autosave: true
  has_many :game_players
  has_many :games, inverse_of: :creator, dependent: :destroy
  has_many :messages, inverse_of: :recipient
  has_many :sent_messages, inverse_of: :sender, class_name: "Message"

  ## Plugins
  slug :handle
  geocoded_by :location

  ## Indexes
  index({handle: 1, email: 1, uuid: 1}, {unique: true})
  index zip_code: 1, city: 1, state: 1

  attr_reader :password

  ## Callbacks
  before_save :generate_gravatar_hash
  after_create :deliver_welcome_email
  after_create :link_game_players
  before_save :geocode, if: ->(player) { player.location.present? && (player.zip_code_changed? || player.city_changed? || player.state_changed?) }

  ## Validations
  validates_presence_of :email, :handle
  validates_uniqueness_of :email, :handle
  validates_inclusion_of :image_source, in: [ImageSource::Facebook, ImageSource::Gravatar], allow_blank: true
  validates_format_of :email, with: EmailAddressValidation::EMAIL_ADDRESS_EXACT_PATTERN, allow_blank: true
  validates_confirmation_of :password
  validates_presence_of :password_digest, if: ->(player) { player.uid.blank? }
  validates_inclusion_of :favorite_color, in: GamePlayer::COLORS, allow_blank: true

  ## Scopes
  scope :public_profiles, ->() { where(public_profile: true).asc(:created_at) }

  ## Facebook image size options
  ## square=50x50, small=50xVariable, normal=100xVariable, large=200xVariable
  def profile_image_path(size=:normal)
    default_avatar_path = "https://risk2210.net/assets/default_avatar.png"
    if image_source == ImageSource::Facebook && facebook_image_url
      return facebook_image_url.gsub("http://", "https://") + "?type=#{size}"
    elsif image_source == ImageSource::Gravatar
      gravatar_size = case size
        when :square, :small ; 50
        when :normal ; 100
        when :large ; 200
      end
      return "https://www.gravatar.com/avatar/#{gravatar_hash}?size=#{gravatar_size}&default=#{CGI::escape(default_avatar_path)}"
    else
      return default_avatar_path
    end
  end

  def change_password(password_attributes={}, options={})
    validate_old_password = options.fetch(:validate_old_password, true)
    if password_digest.present? && validate_old_password && !valid_password?(password_attributes.delete(:old_password))
      errors.add(:base, "Old password doesn't match")
      return false
    elsif password_attributes[:password].blank?
      errors.add(:password, "Password can't be blank")
      return false
    else
      return update_attributes(password_attributes)
    end
  end

  def location
    @location ||= begin
      @location = ""
      @location = city if city.present?
      @location = "#{@location}, " if city.present? && state.present?
      @location = "#{@location}#{state}" if state.present?
      @location = "#{@location} #{zip_code}" if zip_code.present?
      @location
    end
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password, cost: Rails.configuration.password_cost)
    end
  end

  def set_login_stats
    self.login_count   = self.login_count + 1
    self.last_login_at = Time.now
  end

  def valid_password?(unencrypted_password)
    password_digest.present? && BCrypt::Password.new(password_digest) == unencrypted_password
  end

  def request_password_reset!
    self.password_reset_token = SecureRandom.hex(8)
    self.save
    PlayerMailer.password_reset(self).deliver_now
  end

  def name
    @name ||= begin
      if first_name.present? || last_name.present?
        [first_name, last_name].compact.join(" ")
      else
        slug
      end
    end
  end

private

  def generate_gravatar_hash
    if email.present? && email_changed?
      self.gravatar_hash = Digest::MD5.hexdigest(email)
    end
  end

  def deliver_welcome_email
    PlayerMailer.welcome_email(self).deliver_now
  end

  def link_game_players
    GamePlayer.where(handle: handle).each do |game_player|
      game_player.update_attribute(:player_id, self.id)
    end
  end

end
