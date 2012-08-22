class Pub < ActiveRecord::Base
  attr_accessible :name
  has_many :trips, :dependent => :destroy
end
