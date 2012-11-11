class AddOrderCutoffToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :order_cutoff, :datetime
  end
end
