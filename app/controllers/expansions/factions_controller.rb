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
      raise Mongoid::Errors::DocumentNotFound.new(Faction, params[:id], params[:id]) if @faction.nil?
      @page_title = "#{@faction.name} Faction"

      respond_with(@faction, root: false)
    end

  end
end
