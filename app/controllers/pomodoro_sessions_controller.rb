class PomodoroSessionsController < ApplicationController
  def index
    @pomodoro_sessions = PomodoroSession.order(created_at: :desc)
    @total_sessions = PomodoroSession.count

    @total_focus_minutes = PomodoroSession.sum(:focus_duration)

    today_sessions = PomodoroSession.where(
      created_at: Time.zone.today.all_day
    )

    @today_sessions_count = today_sessions.count
    @today_focus_minutes = today_sessions.sum(:focus_duration)
  end

  def create
    session = PomodoroSession.create!(
      task_name: params[:task_name],
      focus_duration: params[:focus_duration],
      break_duration: params[:break_duration],
      status: "completed",
      started_at: params[:started_at],
      completed_at: Time.current,
      completed_cycles: 1
    )

    render json: {
      message: "Pomodoro session saved successfully!",
      id: session.id
    }, status: :created
  end
end