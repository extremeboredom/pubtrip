class Group < ActiveRecord::Base
  attr_accessible :name, :owner_id

  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  has_many :members

  validates_presence_of :name
  validates_presence_of :owner

end
