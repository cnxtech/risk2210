class ApplicationController < ActionController::Base
  include Authentication

  class_attribute :active_tab

  protect_from_forgery

  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    format = params.fetch(:format, "html")
    if format == "html"
      render file: "#{Rails.root}/public/404", status: 404, format: "html"
    else
      head :not_found
    end
  end

  def self.active_tab(tab=nil)
    self.active_tab = tab
  end

end
