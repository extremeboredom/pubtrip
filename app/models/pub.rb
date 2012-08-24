class Pub < ActiveRecord::Base
  attr_accessible :name
  has_many :trips, :dependent => :destroy
  has_many :menu_items, :dependent => :destroy
end
