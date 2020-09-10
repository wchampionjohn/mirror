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

  ICONS = {
    EAT: 'fas fa-utensils',
    BUS: 'fas fa-bus',
    Bicycle: 'fas fa-bicycle',
    Taxi: 'fas fa-taxi',
    Truck: 'fas fa-truck',
    Plane: 'fas fa-plane',
    Cloud: 'fas fa-cloud',
    Ticket: 'fas fa-ticket-alt',
    Mask: 'fas fa-mask',
    Fish: 'fas fa-fish',
    Utensils: 'fas fa-utensils',
    Tshirt: 'fas fa-tshirt',
    Shopping: 'fas fa-shopping-cart',
    Film: 'fas fa-film',
    Beer: 'fas fa-beer',
    Coffee: 'fas fa-coffee',
    Cocktail: 'fas fa-cocktail',
    Dumbbell: 'fas fa-dumbbell',
    Bed: 'fas fa-bed',
    Book: 'fas fa-book',
    Bullhorn: 'fas fa-bullhorn',
    :'Charging-station' => 'fas fa-charging-station',
    Dharmachakra: 'fas fa-dharmachakra',
    :'Map-marker' => 'fas fa-map-marker-alt',
    Gamepad: 'fas fa-gamepad',
    Home: 'fas fa-home',
    Capsules: 'fas fa-capsules',
    :"Concierge-bell" => 'fas fa-concierge-bell',
    Music: 'fab fa-itunes-note',
    Astronaut: 'fas fa-user-astronaut',
  }

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
