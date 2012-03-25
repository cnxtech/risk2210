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

  def navigation_item(title, path, key)
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
  
  def button(text, options={})
    
    if options[:icon]
      icon_color = options[:icon_grey] && options[:icon_grey] == true ? "" : " icon-white"
      icon = content_tag(:i, "", class: "icon-#{options[:icon]}#{icon_color}") + " "
    else
      icon = ""
    end
    
    button_type = options[:button_type] || "primary"
    tag_options = {class: "btn #{button_type}"}

    if options[:href]
      tag = :a 
      tag_options[:href] = options[:href]
    else
      tag = :button
      tag_options[:type] = options[:type] || :submit
    end

    content_tag(tag, icon + text, tag_options)
  end
  
  def page_title
    return "#{@page_title} | Risk Tracker" if defined?(@page_title)
    return "Risk Tracker"
  end
  
  def link_to_remove_fields(name, form)
    form.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, form, association)
    new_object = form.object.class.reflect_on_association(association).klass.new
    fields = form.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(form.object.class.name.pluralize.downcase + "/" + association.to_s.singularize + "_fields", form: builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
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
  
end
