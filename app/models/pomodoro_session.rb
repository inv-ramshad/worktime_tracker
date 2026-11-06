class PomodoroSession < ApplicationRecord
    validates :task_name, presence: true
    validates :focus_duration,
            numericality: {
              only_integer: true,
              greater_than: 0,
              less_than_or_equal_to: 180
            }

    validates :break_duration,
            numericality: {
              only_integer: true,
              greater_than: 0,
              less_than_or_equal_to: 60
            }

    validates :status,
            inclusion: { in: %w[running paused completed] }
end
