class GamePlayerStat
  include Mongoid::Document
  include Mongoid::Timestamps

  field :units,           type: Integer, default: 3
  field :energy,          type: Integer, default: 3
  field :territory_count, type: Integer
  field :space_stations,  type: Integer, default: 0

  belongs_to :turn
  belongs_to :game_player
  has_and_belongs_to_many :continents

  after_create :cache_game_player_stats

private

  def cache_game_player_stats
    game_player.update_attributes energy:          energy,
                                  units:           units,
                                  territory_count: territory_count,
                                  continent_ids:   continent_ids,
                                  space_stations:  space_stations
  end

end
