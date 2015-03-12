module ApplicationHelper

  def error_messages_for(object)
    return if object.errors.empty?
    header_message = pluralize(object.errors.size, "error") + (object.errors.size > 1 ? " require" : " requires") + " your attention"
    content_tag(:div, class: "alert alert-block alert-danger alert-dismissible fade in") do

      close_link_options = {
        class: "close",
        href: "#",
        data: {
          dismiss: "alert"
        }
      }

      concat(content_tag(:button, content_tag(:span, "&times;".html_safe, aria: {hidden: true}), close_link_options))
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
    close_link_options = {
      class: "close",
      href: "#",
      data: {
        dismiss: "alert"
      },
      aria: {
        label: "Close"
      }
    }

    flash.each do |key, value|
      style_class = case key
        when 'notice' ; "alert-success"
        when 'alert'  ; "alert-danger"
      end
      html += content_tag(:div, (content_tag(:button, content_tag(:span, "&times;".html_safe, aria: {hidden: true}), close_link_options) + content_tag(:i, "", class: "fa fa-info") + content_tag(:span, value, class: "flash-text")), class: "alert alert-dismissible #{style_class} fade in", role: "alert")

    end
    return html.html_safe
  end

  def navigation_item(title, path, key=nil)
    style_class = (key && key == controller.active_tab) ? "active" : ""
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
    if content_for?(:page_title)
      page_title = content_for(:page_title)
      return "#{page_title} | Risk Tracker | Risk 2210 A.D."
    else
      title = controller.active_tab.present? ? controller.active_tab.capitalize : nil
      return "#{title} | Risk Tracker | Risk 2210 A.D." if title
    end
    return "Risk Tracker | Risk 2210 A.D."
  end

  def format_markdown(string)
    return "" if string.blank?
    markdown_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    markdown_renderer.render(string).html_safe
  end

  def facebook_button
    link_to(facebook_authentication_path, class: "btn btn-social btn-facebook") do
      content_tag(:i, nil, class: "fa fa-facebook") + "Login with Facebook"
    end
  end

  def download_expansion_button(path, options={})
    text = options.fetch(:text, "Download Bundled Expansion Pack")
    link_to(content_tag(:i, "", class: "fa fa-arrow-down fa-lg") + " #{text}", path, class: "btn btn-danger btn-large")
  end

end
