class AttendancesController < ApplicationController
    def index
        @attendances = Attendance.order(work_date: :desc)
    end

    def sign_in
        attendance = Attendance.create!(
            work_date: Date.current,
            signed_in_at: Time.current,
            status: "working"
        )
        redirect_to root_path, notice: "Successfully signed in!"
    end

    def take_break
        attendance = Attendance.find(params[:id])
        if attendance.status == "working"
            attendance.break_periods.create!(
                started_at: Time.current
            )
            attendance.update!(status: "on_break")
        end
        redirect_to root_path, notice: "Break started!"
    end

    def resume_work
        attendance = Attendance.find(params[:id])
        if attendance.status == "on_break"
            current_break = attendance.break_periods.where(ended_at: nil).last
            if current_break
                current_break.update!(ended_at: Time.current)
                attendance.update!(status: "working")
            end
        end
        redirect_to root_path, notice: "Welcome back to work!"
    end

    def sign_off
        attendance = Attendance.find(params[:id])

        if attendance.status == "working"
            attendance.update!(
                signed_off_at: Time.current,
                status: "signed_off"
            )
        end
        redirect_to root_path, notice: "Successfully signed off!"
    end

    def re_sign_in
        attendance = Attendance.find(params[:id])

        if attendance.status == "signed_off" &&
            attendance.work_date == Date.current

            now = Time.current

            attendance.transaction do
            # Count the time away from work as a break.
            attendance.break_periods.create!(
                started_at: attendance.signed_off_at,
                ended_at: now
            )

            attendance.update!(
                signed_off_at: nil,
                status: "working"
            )
            end

            redirect_to root_path, notice: "Successfully signed in again!"
        else
            redirect_to root_path, alert: "You cannot sign in again for this attendance."
        end
    end

end
