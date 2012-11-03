class Attendee < ActiveRecord::Base
	belongs_to :user
  belongs_to :trip
  attr_accessible :user, :trip
end
