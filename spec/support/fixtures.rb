module Fixtures
  class Facebook

    def self.me
      {
        "provider" => "facebook",
        "uid" => '750592098',
        "info" => {
          "nickname" => "nick.desteffen",
          "email" => "nick.desteffen@gmail.com",
          "name" => "Nick DeSteffen",
          "first_name" => "Nick",
          "last_name" => "DeSteffen",
          "image" => "http =>//graph.facebook.com/750592098/picture?type=square",
          "urls" => {
            "Facebook" => "http =>//www.facebook.com/nick.desteffen"
          },
          "location" => "Chicago, Illinois"
        },
        "credentials" => {
          "token" => "AAADMjLRob70BAAUV32EicRHN3owCRHZNqrySC3w5K8BQL1VHZVVA4ARJG987DQ3fFETgnz0pGyi8LKZCbWgZAts1lQZD",
          "expires" => "false"
        },
        "extra" => {
          "raw_info" => {
            "id" => '750592098',
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

    def self.player1
      first_name = Faker::Name.first_name
      last_name  = Faker::Name.first_name
      email      = Faker::Internet.free_email
      handle     = "#{first_name[0]}#{last_name}".upcase
      {
        "provider" => "facebook",
        "uid" => "464337127",
        "info" => {
          "nickname" => handle,
          "email" => email,
          "name" => "#{first_name} #{last_name}",
          "first_name" => first_name,
          "last_name" => last_name,
          "image" => "http://graph.facebook.com/464337127/picture?type=square",
          "description" => Faker::Lorem.sentence,
          "urls" => {
            "Facebook" => "http://www.facebook.com/#{first_name}.#{last_name}"
          }
        },
        "credentials" => {
          "token" => "AAADMjLRob70BAMzcBY3eCZCxgnm3tR1sJGCw8ZBst57AABCYqdaFa7ZAJkLlq6kY6gjdcSK1BBEgtKbUY3KqEByb8lFbTQB1JODJAYRr2ZD",
          "expires_at" => 1347832925,
          "expires" => true
        },
        "extra" => {
          "raw_info" => {
            "id" => "464337127",
            "name" => "#{first_name} #{last_name}",
            "first_name" => first_name,
            "middle_name" => "",
            "last_name" => last_name,
            "link" => "http://www.facebook.com/LSMITH",
            "username" => handle,
            "hometown" => {
              "id" => "109216849096476",
              "name" => "Chicago, Illinois"
            },
            "bio" => Faker::Lorem.sentence,
            "work" => [
              {
                "employer" => {
                  "id" => "156223891096511",
                  "name" => Faker::Job.title
                },
                "position" => {
                  "id" => "128674630510351",
                  "name" => Faker::Job.title
                },
                "start_date" => "2011-08"
              },
              {
                "employer" => {
                  "id" => "223742647668475",
                  "name" => Faker::Job.title
                },
                "position" => {
                  "id" => "128674630510351",
                  "name" => Faker::Job.title
                },
                "start_date" => "2011-07"
              },
              {
                "employer" => {
                  "id" => "245321145541707",
                  "name" => Faker::Job.title
                },
                "position" => {
                  "id" => "128674630510351",
                  "name" => Faker::Job.title
                },
                "start_date" => "2011-03"
              },
              {
                "employer" => {
                  "id" => "116860741677367",
                  "name" => Faker::Job.title
                },
                "position" => {
                  "id" => "145617765464974",
                  "name" => Faker::Job.title
                },
                "start_date" => "2009-04"
              },
              {
                "employer" => {
                  "id" => "111078042263414",
                  "name" => Faker::Job.title
                },
                "projects" => [
                  {
                    "id" => "109871969042969",
                    "name" => Faker::Job.title,
                    "start_date" => "2010-09"
                  }
                ]
              }
            ],
            "education" => [
              {
                "school" => {
                  "id" => "111845662166573",
                  "name" => Faker::Education.school
                },
                "year" => {
                  "id" => "141778012509913",
                  "name" => "2008"
                },
                "type" => "High School"
              },
              {
                "school" => {
                  "id" => "157433874304051",
                  "name" => Faker::Education.school
                },
                "concentration" => [
                  {
                    "id" => "136073143125360",
                    "name" => Faker::Education.school
                  }
                ],
                "type" => "College"
              }
            ],
            "gender" => "male",
            "email" => email,
            "timezone" => -5,
            "locale" => "en_US",
            "verified" => true,
            "updated_time" => "2012-05-13T03:41:11+0000"
          }
        }
      }
    end

    def self.player2
      first_name = Faker::Name.first_name
      last_name  = Faker::Name.first_name
      email      = Faker::Internet.free_email
      handle     = "#{first_name[0]}#{last_name}".upcase
      {
        "provider" => "facebook",
        "uid" => "12982980291",
        "info" => {
          "nickname" => handle,
          "email" => email,
          "name" => "#{first_name} #{last_name}",
          "first_name" => first_name,
          "last_name" => last_name,
          "image" => "http://graph.facebook.com/12982980291/picture?type=square",
          "description" => Faker::Lorem.sentence,
          "urls" => {
            "Facebook" => "http://www.facebook.com/#{first_name}.#{last_name}"
          },
          "verified" => true
        },
        "credentials" => {
          "token" => "AAADMjLRob70BAMSyZCdnbfDlxoBOER56IIHp2cMQYS5NPzKJDFL4EWlQinNc7ZBSAfRjJYxWLqbLIzbZAXOcRZCS7z1f30WzyRUWzryUYhKAZDZD",
          "expires_at" => 1353654498,
          "expires" => true
        },
        "extra" => {
          "raw_info" => {
            "id" => "12982980291",
            "name" => "Samantha Doe",
            "first_name" => "Samantha",
            "last_name" => "Doe",
            "link" => "http://www.facebook.com/sam.81983",
            "username" => "sam.81983",
            "about" => Faker::Lorem.sentence,
            "bio" => Faker::Lorem.sentence,
            "quotes" => Faker::Lorem.sentence,
            "gender" => "female",
            "email" => email,
            "timezone"=> -7,
            "locale" => "en_US", "verified" => true,
            "updated_time" => "2012-06-12T12:49:57+0000"
          }
        }
      }
    end

  end
end
