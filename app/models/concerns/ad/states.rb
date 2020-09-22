module Ad::States
  extend ActiveSupport::Concern

  included do

    include AASM

    # TODO 補上rspec
    aasm column: :status do
      state :pending, initial: true
      state :rejection
      state :stopping
      state :running
      state :waiting
      state :ending

      after_all_transitions :log_status_change

      event :checkout do
        transitions from: :stopping, to: :running, guard: :can_be_run?
      end

      event :resume do
        transitions from: :stopping, to: :running, guard: :can_be_run?
      end

      event :ready  do
        transitions from: :pending, to: :waiting, guard: :can_be_ready?
      end

      event :approve  do
        transitions from: [:pending, :waiting], to: :running, guard: :can_be_run?
      end

      event :disapprove do
        transitions from: :pending, to: :rejection
      end

      event :modify do
        transitions from: :rejection, to: :pendding
      end

      event :break do
        transitions from: :running, to: :stopping, guard: :can_not_be_run?
      end

      event :pause do
        transitions from: :running, to: :stopping
      end

      event :trush do
        transitions from: :stopping, to: :ending
      end
    end
  end

  def log_status_change
    # 有必要時再存到DB
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event}) at #{Time.now}"
  end

end
