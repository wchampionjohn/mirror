module Ad::StateValidator

  def can_be_ready?
    start_at > Time.now
  end

  def can_not_be_run?
    !can_be_run?
  end

  def can_be_run?
    budget_enough? && in_open_period?
  end

  def in_open_period?
    Time.now.between?(start_at, end_at.end_of_day)
  end

end
