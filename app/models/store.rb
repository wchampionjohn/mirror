class Store < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :city
  belongs_to :area
  belongs_to :headquarter, counter_cache: true, optional: true
  has_many :age_group_stores
  has_many :age_groups, through: :age_group_stores
  has_many :business_hours, dependent: :destroy
  has_many :introductions, dependent: :destroy
  # validations ...............................................................
  validates_presence_of :name
  validates :commission, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :email,
    presence: false,
    length: { minimum: 10, maximum: 63, message: "長度不正確" },
    #email: { message: "格式不正確" },
    allow_blank: true
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  enum gender: [:male, :female]

  DEFAULT_VALUES = {
    commission: 15,
    information_menu_icon: 'fas fa-home',
    service_menu_icon: 'fas fa-could',
  }

  ICONS = Settings.icons

  accepts_nested_attributes_for :business_hours
  # class methods .............................................................
  # public instance methods ...................................................
  def full_area
    "#{city.name}#{area.name}"
  end

  def installed?
    business_hours.any? { |bh| bh.is_openness }
  end

  def current_step
    @current_step || 1
  end

  def current_step= stage
    @current_step = stage
  end

  def vaild_commision
    headquarter.present? ? headquarter.commission : commission
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
