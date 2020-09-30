class Device < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :store
  belongs_to :app_version, optional: true
  # validations ...............................................................
  validates_presence_of :name, :mac
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  delegate :name, to: :store, prefix: true
  # class methods .............................................................
  # public instance methods ...................................................
  def last_report_gap
    (Time.now - self.last_report_time.to_i).to_i
  end

  def out_of_service_minutes
    (self.last_report_gap / (60)).floor
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
