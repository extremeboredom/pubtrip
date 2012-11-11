class Trip < ActiveRecord::Base
  attr_accessible :date, :name, :pub_id, :date_date, :date_time, :order_cutoff_date, :order_cutoff_time
  attr_accessor :date_date, :date_time
  attr_accessor :order_cutoff_date, :order_cutoff_time

  belongs_to :pub
  belongs_to :organiser, :class_name => "User", :foreign_key => "user_id"
  has_many :attendees
  has_many :users, :through => :attendees

  before_validation :make_date, :make_order_cutoff
  validates :name, :presence => true
  validates :date, :presence => true
  validates :pub, :presence => true

  scope :upcoming, lambda { where("date >= ?", Date.today).order("date") }

  def make_date
    if @date_date.present? && @date_time.present?
      self.date = DateTime.new(@date_date.year,
                               @date_date.month,
                               @date_date.day,
                               @date_time.hour,
                               @date_time.min)
    end
  end

  def date_date
    return @date_date if @date_date.present?
    return self.date if self.date.present?
    return Date.today
  end

  def date_time
    return @date_time if @date_time.present?
    return self.date if self.date.present?
    return Time.now
  end 


  def date_date=(new_date)
    @date_date = self.string_to_datetime(new_date, "%d/%m/%Y")
  end


  def date_time=(new_time)
    @date_time = self.string_to_datetime(new_time, "%H:%M")
  end

  def make_order_cutoff
    if @order_cutoff_date.present? && @order_cutoff_time.present?
      self.order_cutoff = DateTime.new(@order_cutoff_date.year,
                                       @order_cutoff_date.month,
                                       @order_cutoff_date.day,
                                       @order_cutoff_time.hour,
                                       @order_cutoff_time.min)
    end
  end

  def order_cutoff_date
    return @order_cutoff_date if @order_cutoff_date.present?
    return self.order_cutoff if self.order_cutoff.present?
    return nil
  end

  def order_cutoff_time
    return @order_cutoff_time if @order_cutoff_time.present?
    return self.order_cutoff if self.order_cutoff.present?
    return nil
  end 


  def order_cutoff_date=(new_date)
    @order_cutoff_date = self.string_to_datetime(new_date, "%d/%m/%Y")
  end


  def order_cutoff_time=(new_time)
    @order_cutoff_time = self.string_to_datetime(new_time, "%H:%M")
  end

  protected

  def string_to_datetime(value, format)
    return value unless value.is_a?(String)

    begin
      DateTime.strptime(value, format)
    rescue ArgumentError
      nil
    end
  end

end
