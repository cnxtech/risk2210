class PagesController < ApplicationController

  def home
  end

  def resources
    self.active_tab = :resources
  end

  def about
  end

  def api_docs
  end

end
