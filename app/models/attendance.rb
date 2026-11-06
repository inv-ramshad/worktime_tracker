class Attendance < ApplicationRecord
    has_many :break_periods, dependent: :destroy
    
    validates :work_date, presence: true, uniqueness: true
    validates :signed_in_at, presence: true
    validates :status, inclusion: { in: %w[working on_break signed_off] }

    # Returns total break duration in seconds
    def total_break_seconds(at: Time.current)
        break_periods.sum do |break_period|
            break_end = break_period.ended_at || signed_off_at || at

            duration = break_end - break_period.started_at

            [duration, 0].max
        end.to_i
    end

    # Returns actual working duration in seconds
    def worked_seconds(at: Time.current)
        return 0 unless signed_in_at

        end_time = signed_off_at || at

        total_seconds = end_time - signed_in_at

        actual_seconds = total_seconds - total_break_seconds(at: at)

        [actual_seconds, 0].max.to_i
    end

    # Converts seconds into HH:MM:SS format
    def formatted_duration(seconds)
        hours = seconds / 3600
        minutes = (seconds % 3600) / 60
        remaining_seconds = seconds % 60

        format("%02d:%02d:%02d", hours, minutes, remaining_seconds)
    end

    # Returns formatted working time
    def formatted_worked_time(at: Time.current)
        formatted_duration(worked_seconds(at: at))
    end

    # Returns formatted break time
    def formatted_break_time(at: Time.current)
        formatted_duration(total_break_seconds(at: at))
    end

    def total_break_seconds(at: Time.current)
        break_periods.sum do |break_period|
        break_end = break_period.ended_at || signed_off_at || at

        duration = break_end - break_period.started_at

        [duration, 0].max
        end.to_i
    end

    def worked_seconds(at: Time.current)
        return 0 unless signed_in_at

        end_time = signed_off_at || at

        total_seconds = end_time - signed_in_at

        actual_seconds = total_seconds - total_break_seconds(at: at)

        [actual_seconds, 0].max.to_i
    end

    def formatted_duration(seconds)
        hours = seconds / 3600
        minutes = (seconds % 3600) / 60
        remaining_seconds = seconds % 60

        format("%02d:%02d:%02d", hours, minutes, remaining_seconds)
    end

    def formatted_worked_time(at: Time.current)
        formatted_duration(worked_seconds(at: at))
    end

    def formatted_break_time(at: Time.current)
        formatted_duration(total_break_seconds(at: at))
    end

    def formatted_duration(seconds)
        hours = seconds / 3600
        minutes = (seconds % 3600) / 60
        remaining_seconds = seconds % 60
        format("%02d:%02d:%02d", hours, minutes, remaining_seconds)
    end

    def formatted_worked_time(at: Time.current)
        formatted_duration(worked_seconds(at: at))
    end

    def formatted_break_time(at: Time.current)
        formatted_duration(total_break_seconds(at: at))
    end

    def expected_sign_off_at(at: Time.current)
        return nil unless signed_in_at

        standard_duration = 9.hours + 30.minutes
        allowed_break_seconds = 1.hour.to_i

        extra_break_seconds = [
            total_break_seconds(at: at) - allowed_break_seconds,
            0
        ].max

        signed_in_at + standard_duration + extra_break_seconds.seconds
    end

end
