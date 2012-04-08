module Expansions
  class FactionsController < ApplicationController

    respond_to :html, :json

    active_tab :expansions
    
    def index
      @factions = Faction.all
      @page_title = "Factions Expansion"

      respond_with(@factions)
    end
    
    def show
      @faction = Faction.where(slug: params[:id]).first
      @page_title = "#{@faction.name} Faction"
      
      respond_with(@faction)
    end
    
  end
end