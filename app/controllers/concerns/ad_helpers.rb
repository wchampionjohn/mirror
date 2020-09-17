module AdHelpers
  extend ActiveSupport::Concern

  included do
    helper_method :all_category_items, :current_category_items
    before_action :setup_material, only: [:new, :create]
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

  def setup_material
    if current_object.new_record?

      if current_object.file_code.nil?
        current_object.file_code = params["file_code"] || SecureRandom.hex(32)
      end

      tmp_file = TmpFile.find_by(code: current_object.file_code)
    end
  end

end

