module Expansions
  class FactionsController < ApplicationController

    active_tab :expansions

    def index
      @factions = Faction.non_default
    end

    def show
      @faction = Faction.find(params[:id])
      raise Mongoid::Errors::DocumentNotFound.new(Faction, params[:id], params[:id]) if @faction.nil?
    end

  end
end
