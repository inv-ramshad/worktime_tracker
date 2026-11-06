require "test_helper"

class PomodoroSessionTest < ActiveSupport::TestCase
  test "should create a valid pomodoro session" do
    session = PomodoroSession.new(
      task_name: "Learning Rails",
      focus_duration: 25,
      break_duration: 5,
      status: "completed",
      started_at: Time.current,
      completed_at: Time.current,
      completed_cycles: 1
    )

    assert session.valid?
  end

  test "should require task name" do
    session = PomodoroSession.new(
      focus_duration: 25,
      break_duration: 5,
      status: "completed",
      started_at: Time.current
    )

    assert_not session.valid?
  end

  test "should reject invalid focus duration" do
    session = PomodoroSession.new(
      task_name: "Learning Rails",
      focus_duration: 0,
      break_duration: 5,
      status: "completed",
      started_at: Time.current
    )

    assert_not session.valid?
  end
end