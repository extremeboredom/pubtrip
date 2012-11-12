require 'mandrill'

namespace :scheduler do
  desc "Send notifications of orders to the trip organiser"
  task :send_order_notifications => :environment do
    include Pubtrip::Application.routes.url_helpers
    # Grab Trips that need notifications sending.
    trips = Trip.where('notification_sent = :sent AND order_cutoff <= :now', :sent => false, :now => DateTime.now)

    unless trips.empty?
      m = Mandrill::API.new(ENV['MANDRILL_APIKEY'])
      trips.each do |trip|
        url = trip_orders_url(trip, :host => ENV['APP_HOST'])
        m.messages().send({
          html: "Time to <a href='#{url}'>check the orders</a>.",
          subject: "The orders are ready.",
          from_email: 'notifications@pubtrip.bit-universe.com',
          from_name: 'Pubtrip Notifications',
          to: [{
            email: trip.organiser.email,
            name: trip.organiser.name
          }]
        })
        trip.notification_sent = true
        trip.save
      end
    end
  end

end
