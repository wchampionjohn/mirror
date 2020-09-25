class Program < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :channel
  belongs_to :current_screenshot, class_name: 'Screenshot', foreign_key: 'screenshot_id', optional: true
  has_many :screenshots, dependent: :destroy
  # validations ...............................................................
  validates_presence_of :name, :seconds, :video
  # callbacks .................................................................
  before_create do
    self.position ||= self.latest_position
  end

  after_create do
    Program::AutomaticSetVideoPlayTimeJob.perform_later(self.id)

    create_screenshots
  end

  # scopes ....................................................................
  scope :active, -> { where(is_active: true) }
  # additional config .........................................................
  mount_uploader :video, ProgramVideoUploader

  DEFAULT_VALUES = {
    seconds: 300,
    is_active: true
  }

  SCREENSHOT_TIMES = [1, 5 , 10 ,15, 20]
  # class methods .............................................................
  # public instance methods ...................................................
  def latest_position
    current_latest_record = self.class.where(channel_id: self.channel.id).order(position: :desc).take

    if current_latest_record
      current_latest_record.position + 1
    else
      1
    end
  end

  def swap_with! target
    self.position, target.position = target.position, self.position
    save and target.save
  end

  def suspend
    self.is_active = false
    self.position = nil
    save
  end

  def recover
    self.is_active = true
    self.position = latest_position
    save
  end

  def create_screenshots
    video_path = video.file.file
    SCREENSHOT_TIMES.each do |second|
      screenshot = ScreenshotService.new(video_path, second).perform
      self.screenshots.create image: File.open(screenshot.path)
      self.update_column(:screenshot_id, self.screenshots.first.id)
    end
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
