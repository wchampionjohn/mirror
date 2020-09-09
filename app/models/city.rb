class City < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  has_many :areas
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  default_scope { where(available: true).order(position: :asc) }
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end