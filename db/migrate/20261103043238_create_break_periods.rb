class CreateBreakPeriods < ActiveRecord::Migration[8.1]
  def change
    create_table :break_periods do |t|
      t.references :attendance, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
