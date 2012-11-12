class AddNotificationSentToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :notification_sent, :boolean
  end
end
