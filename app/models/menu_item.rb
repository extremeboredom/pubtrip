class MenuItem < ActiveRecord::Base
  attr_accessible :description, :name, :price, :pub_id

  belongs_to :pub
end
