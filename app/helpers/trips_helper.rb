module TripsHelper
  def number_of_orders(trip)
    trip.attendees.count(:joins => :order)
  end
end
