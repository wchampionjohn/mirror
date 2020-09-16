module AdHelpers
  extend ActiveSupport::Concern
  included do
    helper_method :all_category_items, :current_category_items
  end


  def all_category_items
    Ad::CategoryItem.all.map { |item| item.attributes.slice(*["id", "category_id", "name"])}
  end

  def current_category_items
    if current_object.category.blank?
      []
    else
      current_object.category.items.options(include_blank: false)
    end
  end

  def current_category_items
    if current_object.category.blank?
      []
    else
      current_object.category.items.options(include_blank: false)
    end
  end


end

