class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :group, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
