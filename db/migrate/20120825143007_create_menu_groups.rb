class CreateMenuGroups < ActiveRecord::Migration
  def change
    create_table :menu_groups do |t|
      t.string :name
      t.text :description
      t.references :pub

      t.timestamps
    end
  end
end
