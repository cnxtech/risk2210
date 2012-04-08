module Expansions
  class CommandersController < ApplicationController

    active_tab :expansions

    def tech
      @page_title = "Tech Commander Expansion"
    end

    def resistance
      @page_title = "Resistance Commander Expansion"
    end
    
  end
end
