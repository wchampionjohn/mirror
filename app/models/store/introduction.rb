class Store::Introduction < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :store
  # validations ...............................................................
  validates_presence_of :attachment
  # callbacks .................................................................
  # scopes ....................................................................
  scope :services, -> { where(menu_type: :service) }
  scope :information, -> { where(menu_type: :information) }
  # additional config .........................................................
  enum menu_type: [:information, :service]

  mount_uploader :attachment, ImageUploader

  # class methods .............................................................
  # public instance methods ...................................................
  def formated_api
    {
      url: self.attachment.url,
      md5: self.md5,
    }
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
