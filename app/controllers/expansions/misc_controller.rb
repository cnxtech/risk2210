module Expansions
  class MiscController < ApplicationController

    active_tab :expansions

    def amoebas
      @page_title = "Invasion of the Giant Amoebas Expansion"
    end

    def galactic
      @page_title = "Galactic Risk"
    end

    def capitals
      @page_title = "Capitals Risk"
    end

  end
end
