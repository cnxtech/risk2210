class ChartDataFormatter

  def initialize(game, options={})
    @game         = game
    @game_players = game.game_players
    @turns        = game.turns.order_by(created_at: "asc")
    @formatter    = options.fetch(:formatter, :to_json)
  end

  metrics = [
    {key: :territories,     starting_value: :starting_territory_count,  metric_method: :territory_count},
    {key: :units,           starting_value: :min_units,                 metric_method: :units},
    {key: :energy,          starting_value: :min_energy,                metric_method: :energy},
    {key: :space_stations,  starting_value: :starting_space_stations,   metric_method: :space_stations},
    {key: :continent_bonus, starting_value: 0,                          metric_method: :continent_bonus}
  ]

  metrics.each do |metric|
    define_method(metric[:key]) do
      series_data = []
      @game_players.each do |game_player|

        start_value = metric[:starting_value].is_a?(Symbol) ? game_player.send(metric[:starting_value]) : metric[:starting_value]

        item = {
          key:    game_player.handle,
          color:  GamePlayer.hex_color(game_player.color),
          values: [[0, start_value]]
        }

        @turns.each_with_index do |turn, index|
          data = turn.game_player_stats.detect{|game_player_stat| game_player_stat.game_player == game_player}.send(metric[:metric_method])
          item[:values] << [(index + 1), data]
        end

        series_data << item
      end
      return series_data.send(@formatter)
    end
  end

end
