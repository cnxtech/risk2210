module ApplicationHelper
  
  def error_messages_for(object)
    return if object.errors.empty?
    header_message = pluralize(object.errors.size, "error") + (object.errors.size > 1 ? " require" : " requires") + " your attention"
    content_tag(:div, class: "alert alert-block alert-error") do
      close_link_options = {class: "close", href: "#"}
      close_link_options["data-dismiss"] = "alert"
      concat(content_tag(:a, "&times;".html_safe, close_link_options))
      concat(content_tag(:h4, header_message, class: "alert-heading"))
      concat(content_tag(:ul) do
        object.errors.full_messages.each do |message|
          concat(content_tag(:li, message))
        end
      end)
    end
  end

  def flash_messages
    return if flash.empty?
    html = ""
    close_link_options = {class: "close", href: "#"}
    close_link_options["data-dismiss"] = "alert"
    
    flash.each do |key, value|
      style_class = case key
        when :notice ; "alert-success"
        when :alert ; "alert-error"
      end
      html += content_tag(:div, (content_tag(:a, "&times;".html_safe, close_link_options) + value), class: "alert fade in #{style_class}") 
    end
    return html.html_safe
  end

  def navigation_item(title, path, key=nil)
    style_class = key == controller.active_tab ? "active" : ""
    content_tag(:li, link_to(title, path), class: style_class)
  end
  
  def format_timestamp(timestamp)
    return if timestamp.blank?
    timestamp.strftime("%m/%d/%Y %I:%M%p").downcase
  end
  
  def format_date(timestamp)
    return if timestamp.blank?
    timestamp.strftime("%m/%d/%Y").downcase
  end
  
  def page_title
    return "#{@page_title} | Risk Tracker | Risk 2210 A.D." if defined?(@page_title)
    return "Risk Tracker | Risk 2210 A.D."
  end
    
  def yes_or_no(boolean)
    boolean ? "Yes" : "No"
  end
  
  def logged_in?
    current_player.present?
  end
  
  def format_markdown(string)
    MARKDOWN_RENDERER.render(string).html_safe
  end

  def facebook_button(options={})
    size = options.fetch(:size, "")
    button = content_tag(:i, "", class: "icon-facebook-sign icon-large") + " Login with Facebook"
    link_to button, facebook_authentication_path, class: "btn btn-inverse #{size}"
  end
  
end
