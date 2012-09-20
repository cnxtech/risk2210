module Expansions
  class FactionsController < ApplicationController

    respond_to :html, :json

    active_tab :expansions
    
    def index
      @factions = Faction.non_default
      @page_title = "Factions Expansion"

      respond_with(@factions)
    end
    
    def show
      @faction = Faction.find(params[:id])
      @page_title = "#{@faction.name} Faction"
      
      respond_with(@faction)
    end
    
  end
end