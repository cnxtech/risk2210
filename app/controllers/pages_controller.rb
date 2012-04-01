class PagesController < ApplicationController

  active_tab :home
  
  def home
  end

  def resources
    self.active_tab = :resources
  end

  def about
  end
  
end
