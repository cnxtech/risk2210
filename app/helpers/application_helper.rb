module ApplicationHelper
  
  def error_messages_for(object)
    return if object.errors.empty?
    header_message = pluralize(object.errors.size, "error") + (object.errors.size > 1 ? " require" : " requires") + " your attention"
    content_tag(:div, class: "alert-message block-message error") do
      concat(content_tag(:h2, header_message))
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
  
  def format_timestamp(timestamp)
    return if timestamp.blank?
    timestamp.strftime("%m/%d/%Y %I:%M%p").downcase
  end
  
  def format_date(timestamp)
    return if timestamp.blank?
    timestamp.strftime("%m/%d/%Y").downcase
  end
  
  def button(text, options={})
    type = options[:type] || :submit
    content_tag(:button, text, class: "btn primary", type: type)
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
