class Ad < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  attr_accessor :advertiser_name
  # relationships .............................................................
  belongs_to :category
  belongs_to :category_item
  belongs_to :advertiser
  has_many :ad_age_groups
  has_many :age_groups, through: :ad_age_groups
  # validations ...............................................................
  validates_presence_of :name, :seconds, :budget, :start_at, :end_at
  # callbacks .................................................................
  before_validation do
    if self.advertiser_name.present?
      created_advertiser = Advertiser.new
      created_advertiser.name = self.advertiser_name
      created_advertiser.save!
      self.advertiser = created_advertiser
    end
  end
  # scopes ....................................................................
  # additional config .........................................................
  DEFAULT_VALUES = {
    ad_type: :carousel,
    seconds: 30,
    budget: 0,
    cpm: 0.0,
    cpv: 0.0,
  }

  enum gender: [:male, :female]
  enum ad_type: [:carousel, :precise, :reserve]

  mount_uploader :banner, ImageUploader
  mount_uploader :screenshot, ImageUploader
  mount_uploader :material, AdMaterialUploader

  # class methods .............................................................
  # public instance methods ...................................................
  def create_screenshot
    material_path =  material.file.file
    movie = ScreenshotService.new(material_path, 10).perform
    update_attribute(:screenshot, File.open(movie.path))
  end

  def unit_price
    [:cpm, :cpv].reduce([]) do |accumulator, unit|
      price = send(unit)
      accumulator << "#{price}/#{unit}" if price && !price.zero?
      accumulator
    end
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
