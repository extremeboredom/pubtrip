class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :attendee
      t.text :notes

      t.timestamps
    end
  end
end
