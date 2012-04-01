module Expansions
  class FactionsController < ApplicationController

    respond_to :html, :json

    active_tab :expansions
    
    def index
      @factions = Faction.all
      respond_to do |format|
        format.json {render json: {:factions => @factions,  callback: params["_dc"]}}
        format.html{}
      end
    end
    
    def show
      @faction = Faction.where(slug: params[:id]).first
    end
    
  end
end