class PagesController < ApplicationController

  def home
  end

  def resources
    self.active_tab = :resources
  end

  def about
    render layout: "no_sidebar"
  end

  def api_docs
  end

end
