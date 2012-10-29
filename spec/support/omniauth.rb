OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
  provider: 'facebook',
  uid:      '123545',
  info: {
    nickname: "Payton Dog",
    email:    "payton@dog.com",
    first_name: "Payton",
    last_name: "Dog",
    image: "http://graph.facebook.com/123545/picture?type=square",
    urls: {
      Facebook: "http://facebook.com/payton.dog"
    }
  },
  location: "Chicago, Illinois",
  extra:{
    raw_info: {
      location: {
        name: "Chicago, Illinois"
      }
    }
  }
})