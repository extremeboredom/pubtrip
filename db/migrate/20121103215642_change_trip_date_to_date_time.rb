class ChangeTripDateToDateTime < ActiveRecord::Migration
  def up
    change_table :trips do |t|
      t.change :date, :datetime
    end
  end

  def down
    change_table :trips do |t|
      t.change :date, :date
    end
  end
end
