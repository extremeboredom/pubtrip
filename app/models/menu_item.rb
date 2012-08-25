class MenuItem < ActiveRecord::Base
  attr_accessible :description, :name, :price
  belongs_to :menu_group
end
