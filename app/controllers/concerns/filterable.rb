module Filterable
  extend ActiveSupport::Concern

  included do
    helper_method :filter_hint, :enable_search?, :selectors
  end


  def filter_hint
    hint = "依照"

    translation = I18n.t('filter')
    humanlize_columns = filter_columns.map do | column|

      translation.dig(model_class_name.downcase.to_sym, column.to_sym) || model_class.send(:human_attribute_name, column)
      #if column.include? '.'
        #relation_model_name, relation_column_name = column.split('.')
        #relation_model_name.capitalize.constantize.send(:human_attribute_name, relation_column_name)
      #else

      #end
    end

    hint << humanlize_columns.join(', ')
    hint << '過濾資料'
  end

  def filter_key
    result = ''

    exclude_dot_columns = filter_columns.select { |column| column.exclude? '.' }
    include_dot_columns = filter_columns.select { |column| column.include? '.' }

    result << "#{exclude_dot_columns.join('_or_')}"

    if include_dot_columns.size > 0
      result << "_or_#{include_dot_columns.join('_or_').gsub('.', '_')}"
    end

    "#{result}_cont_any"
  end

  def enable_search?
    !filter_columns.blank?
  end

  def filter_columns
    []
  end

  def selectors
    {}
  end

  def selector_params
    params[:selector].try(:to_unsafe_h) || {}
  end

  def formated_selector_params # for ransack
    selector_params.each_with_object({}) do |pair, result|
      # ex { 'state_eq' => 'stoping', 'adertiser_id' => 1 }
      result[pair.first + "_eq"] = pair.last if pair.last.present?
    end
  end

end
