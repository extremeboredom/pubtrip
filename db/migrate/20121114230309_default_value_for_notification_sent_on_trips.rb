class DefaultValueForNotificationSentOnTrips < ActiveRecord::Migration
  def up
    change_column :trips, :notification_sent, :boolean, :default => false
  end

  def down
    change_column :trips, :notification_sent, :boolean
  end
end
