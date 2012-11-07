class Attendee < ActiveRecord::Base
	belongs_to :user
  belongs_to :trip
  has_one :order, :dependent => :destroy
  
  attr_accessible :user, :trip
end
