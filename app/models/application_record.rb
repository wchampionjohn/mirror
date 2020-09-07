class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_initialize :default_values, if: :need_set_default_values?

  def default_values
    self.class::DEFAULT_VALUES.each do |column_name,  default_value|
      send(:"#{column_name}=", default_value) if send(column_name).blank?
    end
  end

  def need_set_default_values?
    new_record? && self.class.const_defined?('DEFAULT_VALUES')
  end

  def self.options settings = {}
    default_settions = { include_blank: 'All', text_column: :name }
    settings = default_settions.merge settings

    default_option = settings[:include_blank].present? ? [[settings[:include_blank], '']] : []

    options = if block_given?
                yield
              else
                all.map { |record| [record.send(settings[:text_column]), record.id] }
              end

    default_option.concat options
  end

  def self.human_attribute_enum(enum_name, key_is_number = false)
    self.send(enum_name.pluralize).map do |enum_key, enum_value|
      key = if key_is_number
              enum_value
            else
              enum_key
            end
      [key, self.human_attribute_name("#{enum_name}.#{enum_key}")]
    end.to_h
  end
end
