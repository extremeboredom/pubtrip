class Trip < ActiveRecord::Base
  attr_accessible :date, :name, :pub_id
  belongs_to :pub

  validates :name, :presence => true
  validates :date, :presence => true
  validates :pub, :presence => true

  scope :upcoming, lambda { where("date >= ?", Date.today).order("date") }
end
