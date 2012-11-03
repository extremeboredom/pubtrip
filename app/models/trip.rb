class Trip < ActiveRecord::Base
  attr_accessible :date, :name, :pub_id

  belongs_to :pub
  has_many :attendees
  has_many :users, :through => :attendees

  validates :name, :presence => true
  validates :date, :presence => true
  validates :pub, :presence => true

  scope :upcoming, lambda { where("date >= ?", Date.today).order("date") }
end
