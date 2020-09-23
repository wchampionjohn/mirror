class Program < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :channel
  # validations ...............................................................
  # callbacks .................................................................
  before_create do
    self.position ||= self.latest_position
  end

  after_create do
    Program::AutomaticSetVideoPlayTimeJob.perform_later(self.id)
  end

  # scopes ....................................................................
  scope :active, -> { where(is_active: true) }
  # additional config .........................................................
  mount_uploader :video, ProgramVideoUploader

  DEFAULT_VALUES = {
    seconds: 300,
    is_active: true
  }
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
  # protected instance methods ................................................
  # private instance methods ..................................................
end
