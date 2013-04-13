class PagesController < ApplicationController

  active_tab :home

  def home
  end

  def resources
    self.active_tab = :resources
    @page_title = "Resources"
  end

  def about
    @page_title = "About"
  end

  def api_docs
    @page_title = "API Documentation"
  end

end
