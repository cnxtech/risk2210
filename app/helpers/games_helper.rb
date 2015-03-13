module GamesHelper

  def progress_bar(game, options={})
    content_tag(:div, class: "progress") do
      concat(content_tag(:div, class: "progress-bar progress-bar-danger", id: options[:id], role: "progressbar", aria: {valuenow: game.percent_complete, valuemin: 0, valuemax: 100}, style: "width: #{game.percent_complete}%;") do
        concat(content_tag(:span, "#{game.percent_complete}% Complete", class: "sr-only"))
      end)
    end
  end

  def player_handles
    player_handles = Player.all.map(&:handle).map{ |handle| "\"#{handle}\"" }.join(", ")
    return "[#{player_handles}]"
  end

end
