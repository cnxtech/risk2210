module ApplicationHelper
  
  def error_messages_for(object)
    return if object.errors.empty?
    header_message = pluralize(object.errors.size, "error") + (object.errors.size > 1 ? " require" : " requires") + " your attention"
    content_tag(:div, class: "alert alert-block alert-error") do
      concat(content_tag(:a, "&times;".html_safe, class: "close", "data-dismiss" => "alert"))
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
    flash.each do |key, value|
      style_class = case key
        when :notice ; "alert-success"
        when :alert ; "alert-error"
      end
      html += content_tag(:div, (content_tag(:a, "&times;".html_safe, "data-dismiss" => "alert", :class => "close", :href => "#") + value), class: "alert fade in #{style_class}") 
    end
    return html.html_safe
  end

  def navigation_item(title, path, key=nil)
    style_class = ""
    style_class = "active" if key == controller.active_tab
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
    return "#{@page_title} | Risk 2210 A.D. | Risk Tracker" if defined?(@page_title)
    return "Risk Tracker"
  end
  
  def link_to_remove_fields(name, form)
    icon = content_tag(:i, nil, class: "icon-minus icon-white").html_safe
    form.hidden_field(:_destroy) + link_to_function(icon + " " + name, "remove_fields(this)", class: "btn btn-mini btn-danger")
  end
  
  def link_to_add_fields(name, form, association)
    new_object = form.object.class.reflect_on_association(association).klass.new
    fields = form.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(form.object.class.name.pluralize.downcase + "/" + association.to_s.singularize + "_fields", form: builder)
    end
    icon = content_tag(:i, nil, class: "icon-plus icon-white").html_safe
    link_to_function(icon + " " + name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "btn btn-success")
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

  def facebook_button
    button = content_tag(:i, "", class: "icon-facebook-sign icon-large") + " Login with Facebook"
    link_to button, facebook_authentication_path, class: "btn btn-inverse"
  end
  
end
