class Integer
  def to_filesize
    if self > 1024 * 1024
      "#{(self / 1024 / 1024.0).ceil} MB"
    elsif self > 1024
      "#{self / 1024} KB"
    else
      "#{self}"
    end
  end
end
