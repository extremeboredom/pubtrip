class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :attendees
  has_many :trips, :through  => :attendees
  
  attr_accessible :email, :password, :password_confirmation, :remember_me_token

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
end
