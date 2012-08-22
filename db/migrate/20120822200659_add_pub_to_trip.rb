class AddPubToTrip < ActiveRecord::Migration
  def up
  	change_table :trips do |t|
  		t.references :pub
  	end
  end

  def down
  	change_table :trips do |t|
  		remove_column :pub_id
  	end
  end
end
