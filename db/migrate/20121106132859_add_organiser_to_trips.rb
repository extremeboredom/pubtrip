class AddOrganiserToTrips < ActiveRecord::Migration
  def change
    change_table :trips do |t|
      t.references :user
    end
  end
end
