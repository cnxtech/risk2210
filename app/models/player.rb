class Player
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
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
  field :image_url, type: String
  
  slug :handle
  
  has_many :topics, dependent: :destroy, autosave: true
  has_many :comments, dependent: :destroy, autosave: true
   
  attr_accessible :email, :first_name, :last_name, :handle, :city, :state, :zip_code, :bio, :website
  
  def full_name
    return handle if handle.present?
    return first_name if first_name.present?
    return email
  end
  
  def self.omniauthorize(auth)
    Player.where(provider: auth['provider'], uid: auth['uid']).first || self.create_with_omniauth(auth)
  end
  
  private
  
  def self.create_with_omniauth(auth)
    create! do |player|
      player.provider = auth['provider']
      player.uid = auth['uid']
      if auth['info']
         player.first_name = auth['info']['first_name'] || ""
         player.last_name = auth['info']['last_name'] || ""
         player.email = auth['info']['email'] || ""
         player.handle = auth['info']['nickname'] || ""
         player.website = auth["info"]["urls"]["Facebook"]
         player.image_url = auth["info"]["image"] || ""
         
         location = auth["extra"]["raw_info"]["location"]["name"].split(",")
         player.city = location[0].strip
         player.state = States.decode(location[1])
      end
    end
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
