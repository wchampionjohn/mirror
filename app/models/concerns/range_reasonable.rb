module RangeReasonable
  extend ActiveSupport::Concern

  def self.included(base)
    base.validate :start_at_and_end_at_reasonable
  end

  private
  def start_at_and_end_at_reasonable
    range_start = send(start_column)
    range_end = send(end_column)

    if (range_start.present? && range_end.present?) && range_start >= range_end
      message = "#{self.class.human_attribute_name(start_column)}必須大於#{self.class.human_attribute_name(end_column)}"
      errors.add(start_column, message)
      errors.add(end_column, message)
      false
    end
  end

  def start_column
    :start_at
  end

  def end_column
    :end_at
  end

end
