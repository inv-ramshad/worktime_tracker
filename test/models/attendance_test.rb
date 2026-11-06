require "test_helper"

class AttendanceTest < ActiveSupport::TestCase
  test "should create attendance with valid attributes" do
    attendance = Attendance.new(
      work_date: Date.current + 1.day,
      signed_in_at: Time.current,
      status: "working"
    )
    assert attendance.valid?, attendance.errors.full_messages.to_sentence
  end
  
  test "should not allow duplicate attendance for same date" do
    x = Date.new(2026, 1, 1)

    Attendance.create!(
      work_date: x,
      signed_in_at: Time.current,
      status: "working"
    )

    duplicate = Attendance.new(
      work_date: x,
      signed_in_at: Time.current,
      status: "working"
    )

    assert_not duplicate.valid?
  end

  test "should require sign in time" do
    attendance = Attendance.new(
      work_date: Date.current,
      status: "working"
    )

    assert_not attendance.valid?
  end
end