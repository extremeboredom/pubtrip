class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.references :menu_group

      t.timestamps
    end
  end
end
