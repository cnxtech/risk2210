module Expansions
  class CommandersController < ApplicationController

    active_tab :expansions

    def tech
      @page_title = "Tech Commander Expansion"
    end

    def resistance
      @page_title = "Resistance Commander Expansion"
    end

    def galaxy
      @page_title = "Galaxy Commander Expansion"
    end

    def majors_promo_cards
      @page_title = "Majors Promo Cards Expansion"
    end

  end
end
