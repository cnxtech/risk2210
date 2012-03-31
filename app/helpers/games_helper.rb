module GamesHelper

  def progress_bar(game)
    content_tag(:div, class: "progress progress-danger") do
      concat(content_tag(:div, "", class: "bar", style: "width: #{game.percent_complete}%;"))
    end
  end

end
