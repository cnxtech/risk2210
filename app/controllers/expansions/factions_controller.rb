module Expansions
  class FactionsController < ApplicationController

    respond_to :html, :json

    active_tab :expansions
    
    def index
      @factions = Faction.all

      respond_with(@factions)
    end
    
    def show
      @faction = Faction.where(slug: params[:id]).first
      
      respond_with(@faction)
    end
    
  end
end