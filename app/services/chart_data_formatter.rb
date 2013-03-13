class ChartDataFormatter

  def initialize(game, options={})
    @game = game
  end

  def territories
    series_data = []
    @game.game_players.each do |game_player|
      item = {key: game_player.handle, values: [[0, game_player.starting_territory_count]], color: game_player.hex_color}
      @game.turns.order_by(created_at: "asc").each_with_index do |turn, index|
        units = turn.game_player_stats.detect{|game_player_stat| game_player_stat.game_player == game_player}.territory_count
        item[:values] << [(index + 1), units]
      end

      series_data << item
    end
    return series_data
  end

end
