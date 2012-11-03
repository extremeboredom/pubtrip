class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.references :user
      t.references :trip

      t.timestamps
    end
  end
end
