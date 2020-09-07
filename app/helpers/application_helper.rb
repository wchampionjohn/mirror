module ApplicationHelper
  def label_with_icon(text, icon_class, small_text = nil)
    content = "<i class=\"#{icon_class}\"></i> "
    content  << text
    content  << "<small>#{small_text}</small>" if small_text
    content.html_safe
  end

  def form_titleize_for model_name
    model_name.include?('::') ? model_name.split('::').last : model_name
  end

  def admin_can_manage? menu
    if menu['items'].present?
      menu['items'].any? do |item|
        can?(:read, item['resource'].singularize.camelize.constantize)
      end
    else
      can?(:read, menu['resource'].singularize.camelize.constantize)
    end
  end

  def menu_link_of resource
    "/admin/#{resource}"
  end
end
