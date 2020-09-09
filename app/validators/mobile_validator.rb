class MobileValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "格式不正確") unless
      value =~  /\A09\d{2}-?\d{3}-?\d{3}\z/i
  end
end
