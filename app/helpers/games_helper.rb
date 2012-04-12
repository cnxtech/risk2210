module GamesHelper

  def progress_bar(game, options={})
    content_tag(:div, class: "progress progress-danger", id: options[:id]) do
      concat(content_tag(:div, "", class: "bar", style: "width: #{game.percent_complete}%;"))
    end
  end

  def color_class(game_player)
    "#{game_player.color.downcase}"
  end

end
