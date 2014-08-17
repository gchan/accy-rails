module ApplicationHelper

  def flash_class(name)
    case name
      when :success then 'alert-success'
      when :error   then 'alert-danger'
      when :warn    then 'alert-warning'
      when :info    then 'alert-info'
      when :alert   then 'alert-info'
      else 'alert-info'
    end
  end

  def glyphicon(icon)
    content_tag(:span, '', class: "glyphicon glyphicon-#{icon}")
  end

  def nav_action_link(text, path, class_name = '', &block)
    path, class_name = text, path if block_given?

    if current_page?(path) || url_for(path).include?(action_name)
      class_name += ' active'
    end

    content_tag(:li, class: class_name) do
      if block_given?
        link_to path, &block
      else
        link_to text, path
      end
    end
  end

  def dropdown(path, options = {}, &block)
    options[:class] ||= ''
    options[:class] += ' dropdown'
    options[:class] += ' active' if url_for(path).include?(controller_name)

    content_tag :li, options do
      block.call
    end
  end

end
