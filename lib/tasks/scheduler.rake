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

        order_lines = ''
        trip.attendees.each do |attendee|
          order_lines << "<tr><td>#{attendee.order.notes}</td><td>#{attendee.user.name}</td></tr>"
        end

        m.messages().send_template('OrderNotification', [], {
          subject: "The orders are ready.",
          from_email: 'notifications@pubtrip.bit-universe.com',
          from_name: 'Pubtrip Notifications',
          to: [{
            email: trip.organiser.email,
            name: trip.organiser.name
          }],
          global_merge_vars: [
            {
              'name' => 'order',
              'content' => trip.name
            },
            {
              'name' => 'details',
              'content' => order_lines
            }
          ]
        })
        trip.notification_sent = true
        trip.save
      end
    end
  end

end
