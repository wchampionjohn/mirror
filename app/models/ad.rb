class Ad < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include RangeReasonable
  include Ad::StateValidator
  include Ad::States
  # security (i.e. attr_accessible) ...........................................
  attr_accessor :advertiser_name
  attr_accessor :file_code
  # relationships .............................................................
  belongs_to :category
  belongs_to :category_item
  belongs_to :advertiser
  #belongs_to :slat, optional: true
  has_many :ad_age_groups
  has_many :age_groups, through: :ad_age_groups
  # validations ...............................................................
  validates_presence_of :name, :seconds, :budget
  validates_presence_of :start_at, :end_at, unless: :reserve?
  #validates_presence_of :slat, if: :carousel_in_pending?
  # callbacks .................................................................
  before_validation do
    if self.file_code
      tmp_objects = TmpFile.where(code: self.file_code)
      sync_files_from tmp_objects if tmp_objects.present?
    end

    if self.advertiser_name.present?
      created_advertiser = Advertiser.new
      created_advertiser.name = self.advertiser_name
      created_advertiser.save!
      self.advertiser = created_advertiser
    end
  end

  after_save do
    create_screenshot if saved_change_to_material?
  end
  # scopes ....................................................................
  # additional config .........................................................
  DEFAULT_VALUES = {
    start_at: Date.today,
    ad_type: :carousel,
    seconds: 30,
    budget: 0,
    views: 0,
    impressions: 0,
    cpm: 0.0,
    cpv: 0.0,
  }

  enum gender: [:male, :female]
  enum ad_type: [:carousel, :precise, :reserve]
  enum status: [:pending, :stopping, :rejection, :running, :waiting, :ending]

  mount_uploader :banner, ImageUploader
  mount_uploader :screenshot, ImageUploader
  mount_uploader :material, AdMaterialUploader

  alias_attribute :state, :status

  # class methods .............................................................
  # public instance methods ...................................................
  def create_screenshot
    material_path = material.file.file
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

  def material_info
    if new_record?
      file_object('material').info
    else
      {
        url: material.url,
        size: material_size,
        md5: material_md5
      }
    end
  end

  def banner_info
    if new_record?
      file_object('banner').info
    else
      {
        url: banner.url,
        size: banner_size,
        md5: banner_md5
      }
    end
  end

  def file_object column
    new_record? ? TmpFile.find_or_initialize_by(code: self.file_code, column: column) : self
  end

  def period
    start_at .. end_at
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def sync_files_from tmp_objects
    material_tmp = tmp_objects.find_by(column: 'material')
    banner_tmp = tmp_objects.find_by(column: 'banner')

    if Rails.env.production?
      self.remote_material_url = material_tmp.file.url
      self.remote_banner_url = banner_tmp.file.url if banner_tmp.present?
    else
      self.material = material_tmp.file.file
      self.banner = banner_tmp.file.file if banner_tmp.present?
    end

    self.material_md5 = material_tmp.md5
    self.material_size = material_tmp.size

    if banner_tmp.present?
      self.banner_md5 = banner_tmp.md5
      self.banner_size = banner_tmp.size
    end
  end

  def carousel_in_pending?
     carousel? && pending?
  end

end
