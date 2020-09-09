class Store::BusinessHour < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :store
  # validations ...............................................................
  # callbacks .................................................................
  after_initialize :default_times, if: :new_record?
  before_validation do
    self.start_time = start_time.to_time
    self.end_time   = end_time.to_time
  end
  # scopes ....................................................................
  # additional config .........................................................
  enum day: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  # class methods .............................................................

  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
  #
  private
  def default_times
    self.start_time ||= "10:00:00"
    self.end_time ||= "19:00:00"
  end
end