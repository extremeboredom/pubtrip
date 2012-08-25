class MenuGroup < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :menu_items, :dependent => :destroy
  belongs_to :pub
end
