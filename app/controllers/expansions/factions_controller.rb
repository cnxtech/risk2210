module Expansions
  class FactionsController < ApplicationController

    respond_to :html, :json

    active_tab :expansions

    def index
      @factions = Faction.non_default

      respond_with(@factions)
    end

    def show
      @faction = Faction.find(params[:id])
      raise Mongoid::Errors::DocumentNotFound.new(Faction, params[:id], params[:id]) if @faction.nil?

      respond_with(@faction, root: false)
    end

  end
end
