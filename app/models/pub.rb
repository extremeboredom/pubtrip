class Pub < ActiveRecord::Base
  attr_accessible :name
  has_many :trips, :dependent => :destroy
  has_many :menu_groups, :dependent => :destroy
end
