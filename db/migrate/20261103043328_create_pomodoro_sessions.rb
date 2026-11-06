class CreatePomodoroSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :pomodoro_sessions do |t|
      t.string :task_name
      t.integer :focus_duration
      t.integer :break_duration
      t.string :status
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :completed_cycles

      t.timestamps
    end
  end
end
