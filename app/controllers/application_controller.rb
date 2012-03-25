class ApplicationController < ActionController::Base
  include Authentication
  
  class_attribute :active_tab
  
  protect_from_forgery

  def self.active_tab(tab=nil)
    self.active_tab = tab
  end

end
