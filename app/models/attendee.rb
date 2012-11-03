class Attendee < ActiveRecord::Base
	belongs_to :
  attr_accessible :user, :trip
end
