class BreakPeriod < ApplicationRecord
  belongs_to :attendance

  validates :started_at, presence: true

  def duration_seconds(at: Time.current)
    end_time = ended_at || at
    [end_time - started_at, 0].max.to_i
  end

  def formatted_duration(at: Time.current)
    seconds = duration_seconds(at: at)

    hours = seconds / 3600
    minutes = (seconds % 3600) / 60
    remaining_seconds = seconds % 60

    format("%02d:%02d:%02d", hours, minutes, remaining_seconds)
  end
end