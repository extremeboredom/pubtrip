class AttendeesController < ApplicationController
  def create
    @attendee = current_user.attendees.create()
    @attendee.trip_id = params[:trip_id]

    if @attendee.save
      redirect_to @attendee.trip, notice: "You're now attending this trip."
    else
      redirect_to @attendee.trip, notice: "An error occurred when trying to attend this trip."
    end
  end
end
