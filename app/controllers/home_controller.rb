class HomeController < ApplicationController

  active_tab :home
  
  def index
    @players = Player.all
  end
  
end
