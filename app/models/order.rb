class Order < ActiveRecord::Base
  belongs_to :attendee
  
  attr_accessible :attendee, :notes
end
