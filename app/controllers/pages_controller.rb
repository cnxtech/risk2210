class PagesController < ApplicationController

  def home
  end

  def resources
    self.active_tab = :resources
  end

  def about
    self.active_tab = :about
    render layout: "no_sidebar"
  end

  def api_docs
  end

end
