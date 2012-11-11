module TripsHelper
  def number_of_orders(trip)
    trip.attendees.count(:joins => :order)
  end

  def trip_title(trip)
    title = "#{trip.date.strftime '%d/%m/%Y %H:%M'} at #{trip.pub.name}"
    if trip.order_cutoff
      day_format_string = ''
      day_format_string = '%d/%m/%Y ' unless trip.date.to_date === trip.order_cutoff.to_date

      title << " (orders by #{trip.order_cutoff.strftime(day_format_string + '%H:%M')})"
    end
  end
end
