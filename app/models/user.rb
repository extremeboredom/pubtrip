class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :attendees
  has_many :organised_trips, :class_name => "Trip"
  has_many :trips, :through  => :attendees
  has_many :owned_groups, :class_name => "Group"
  
  attr_accessible :first_name,
                  :last_name,
                  :email,
                  :password,
                  :password_confirmation,
                  :remember_me_token

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_uniqueness_of :email

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def organising?(trip)
    trip.organiser == self
  end

  def attending?(trip)
    self.trips.exists? trip
  end
end
