class AttendeesController < ApplicationController
  before_filter :require_login

  def create
    @attendee = current_user.attendees.create()
    @attendee.trip_id = params[:trip_id]

    if @attendee.save
      redirect_to @attendee.trip, notice: "You're now attending this trip."
    else
      redirect_to @attendee.trip, notice: "An error occurred when trying to attend this trip."
    end
  end

  def destroy
    @attendee = Attendee.find(params[:id])

    if current_user.attendees.include? @attendee
      @attendee.destroy
    end

    respond_to do |format|
      format.html { redirect_to trip_url(params[:trip_id])}
    end
  end
end
