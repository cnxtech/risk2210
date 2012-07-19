module Fixtures
  class Facebook

    def self.me
      {
        "provider" => "facebook",
        "uid" => '753509698',
        "info" => {
          "nickname" => "nick.desteffen",
          "email" => "nick.desteffen@gmail.com",
          "name" => "Nick DeSteffen",
          "first_name" => "Nick",
          "last_name" => "DeSteffen",
          "image" => "http =>//graph.facebook.com/753509698/picture?type=square",
          "urls" => {
            "Facebook" => "http =>//www.facebook.com/nick.desteffen"
          },
          "location" => "Chicago, Illinois"
        },
        "credentials" => {
          "token" => "AAADMjLRob70BAAUV32EicRHN3owCqrySC3w5K847rCgpkGZBQL1VHZA4ARJG9ECg9DQ3fFETgnz0pGyi8LKZCbWgZAts1lQZD",
          "expires" => "false"
        },
        "extra" => {
          "raw_info" => {
            "id" => '753509698',
            "name" => "Nick DeSteffen",
            "first_name" => "Nick",
            "last_name" => "DeSteffen",
            "link" => "http =>//www.facebook.com/nick.desteffen",
            "username" => "nick.desteffen",
            "location" => {
              "id" => '108659242498155',
              "name" => "Chicago, Illinois"
            },
            "gender" => "male",
            "email" => "nick.desteffen@gmail.com",
            "timezone" => "-6",
            "locale" => "en_US",
            "verified" => "true",
            "updated_time" => '2011-10-23T20 =>08 =>53+0000'
          }
        }
      }
    end

    def self.dude
      {"provider"=>"facebook", "uid"=>"564037227", "info"=>{"nickname"=>"LALBT", "email"=>"knight829@gmail.com", "name"=>"Luis Alexander Lemus", "first_name"=>"Luis", "last_name"=>"Lemus", "image"=>"http://graph.facebook.com/564037227/picture?type=square", "description"=>"I study music and everything that has to do with music all the aspects of it from musician to all the technical stuff i play Violin , guitar, bass, drums and the piano", "urls"=>{"Facebook"=>"http://www.facebook.com/LALBT"}}, "credentials"=>{"token"=>"AAADMjLRob70BAMzcBY3eCZCxgnm3tR1sJGCw8ZBst57qdaFaBCe01F7ZAJkLlq6kY6gjdcSK1BBEgtKbUY3KqEByb8lFbTQB1JORr20QQZDZD", "expires_at"=>1347832925, "expires"=>true}, "extra"=>{"raw_info"=>{"id"=>"564037227", "name"=>"Luis Alexander Lemus", "first_name"=>"Luis", "middle_name"=>"Alexander", "last_name"=>"Lemus", "link"=>"http://www.facebook.com/LALBT", "username"=>"LALBT", "hometown"=>{"id"=>"109216849096476", "name"=>"Centreville, Virginia"}, "bio"=>"I study music and everything that has to do with music all the aspects of it from musician to all the technical stuff i play Violin , guitar, bass, drums and the piano", "quotes"=>"\"Why not 4:21\"\r\nme talkin to dakota and stevie\r\n\r\n\"Fo Free\"\r\nThat guy from that video\r\n\r\n\"Oh shit dry grass someone go put it out\r\n\r\n\"Jeepers Creepers\"\r\nDakota\r\n\r\n\"My Jeep its a freakin Transformer\"\r\nDakota", "work"=>[{"employer"=>{"id"=>"156223891096511", "name"=>"Fat Crow Antara"}, "position"=>{"id"=>"128674630510351", "name"=>"Audio Engineer"}, "start_date"=>"2011-08"}, {"employer"=>{"id"=>"223742647668475", "name"=>"Atomic Thoughts"}, "position"=>{"id"=>"128674630510351", "name"=>"Audio Engineer"}, "start_date"=>"2011-07"}, {"employer"=>{"id"=>"245321145541707", "name"=>"Cinbersol"}, "position"=>{"id"=>"128674630510351", "name"=>"Audio Engineer"}, "start_date"=>"2011-03"}, {"employer"=>{"id"=>"116860741677367", "name"=>"Freelance Violinist"}, "position"=>{"id"=>"145617765464974", "name"=>"Violinist"}, "start_date"=>"2009-04"}, {"employer"=>{"id"=>"111078042263414", "name"=>"Musician"}, "projects"=>[{"id"=>"109871969042969", "name"=>"Musician for hire", "start_date"=>"2010-09"}]}], "education"=>[{"school"=>{"id"=>"111845662166573", "name"=>"Westfield High School"}, "year"=>{"id"=>"141778012509913", "name"=>"2008"}, "type"=>"High School"}, {"school"=>{"id"=>"157433874304051", "name"=>"G. Martell"}, "concentration"=>[{"id"=>"136073143125360", "name"=>"Music Production & Engineering"}], "type"=>"College"}], "gender"=>"male", "email"=>"knight829@gmail.com", "timezone"=>-5, "locale"=>"en_US", "verified"=>true, "updated_time"=>"2012-05-13T03:41:11+0000"}}}
    end

  end
end