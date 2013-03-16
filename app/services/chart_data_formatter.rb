class ChartDataFormatter

  def initialize(game, options={})
    @game = game
  end

  metrics = [
    {key: :territories,    starting_value_method: :starting_territory_count, metric_method: :territory_count},
    {key: :units,          starting_value_method: :min_units,                metric_method: :units},
    {key: :energy,         starting_value_method: :min_energy,               metric_method: :energy},
    {key: :space_stations, starting_value_method: :starting_space_stations,  metric_method: :space_stations}
  ]

  metrics.each do |metric|
    define_method(metric[:key]) do
      series_data = []
      @game.game_players.each do |game_player|

        item = {
          key:    game_player.handle,
          color:  game_player.hex_color,
          values: [[0, game_player.send(metric[:starting_value_method])]]
        }

        @game.turns.order_by(created_at: "asc").each_with_index do |turn, index|
          data = turn.game_player_stats.detect{|game_player_stat| game_player_stat.game_player == game_player}.send(metric[:metric_method])
          item[:values] << [(index + 1), data]
        end

        series_data << item
      end
      return series_data
    end
  end

end
