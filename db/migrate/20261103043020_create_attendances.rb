class CreateAttendances < ActiveRecord::Migration[8.1]
  def change
    create_table :attendances do |t|
      t.date :work_date
      t.datetime :signed_in_at
      t.datetime :signed_off_at
      t.string :status

      t.timestamps
    end
      add_index :attendances, :work_date, unique: true
  end
end
