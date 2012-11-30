module GamesHelper

  def progress_bar(game, options={})
    content_tag(:div, class: "progress progress-danger", id: options[:id]) do
      concat(content_tag(:div, "", class: "bar", style: "width: #{game.percent_complete}%;"))
    end
  end

  def player_handles
    player_handles = Player.all.map(&:handle).map{ |handle| "\"#{handle}\"" }.join(", ")
    return "[#{player_handles}]"
  end

end
