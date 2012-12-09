class Member < ActiveRecord::Base
  attr_accessible :group_id, :user_id

  belongs_to :group
  belongs_to :user

  validates_presence_of :group
  validates_presence_of :user
  validates_uniqueness_of :user_id, scope: :group_id
  validates_each :user do |record, attr, value|
    if record.group
      record.errors.add attr, 'is also the owner' if record.group.owner == value
    end
  end

  def user_email=(email)
    user = User.find_by_email(email)
    @user_email = email
    self.user = user
  end

  def user_email
    if @user_email
      @user_email
    elsif self.user
      self.user.email
    else
      nil
    end
  end
end
