class OrdersController < ApplicationController
  before_filter :require_login

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @order = Order.new
    @order.attendee = current_attendee(params[:trip_id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(params[:order])
    @order.attendee = current_attendee(params[:trip_id])

    respond_to do |format|
      if @order.save
        format.html { redirect_to [@order.attendee.trip, @order], notice: 'Your order has been accepted' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to [@order.attendee.trip, @order], notice: 'Your order has been updated' }
      else
        format.html { render action: 'edit' }
      end
    end
  end


  def destroy
    @order = Order.find(params[:id])
    trip = @order.attendee.trip

    @order.destroy

    respond_to do |format|
      format.html { redirect_to trip }
    end
  end

  def current_attendee(trip_id)
    Attendee.where(trip_id: trip_id, user_id: current_user).first
  end
end
