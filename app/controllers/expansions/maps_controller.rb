module Expansions
  class MapsController < ApplicationController

    active_tab :expansions

    layout "no_sidebar"

    def mars
      @page_title = "Mars Expansion"
    end

    def io
      @page_title = "Io Expansion"
    end

    def europa
      @page_title = "Europa Expansion"
    end

    def asteroid_colonies
      @page_title = "Asteroid Colonies Expansion"
    end

    def pluto
      @page_title = "Pluto Expansion"
    end

    def arctic
      @page_title = "Arctic Expansion"
    end

    def titan
      @page_title = "Titan Expansion"
    end

    def antarctica
      @page_title = "Antarctica Expansion"
    end

  end
end
