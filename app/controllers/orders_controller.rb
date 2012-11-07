class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @order = Order.new
    @order.attendee = Attendee.find(params[:attendee_id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(params[:order])
    @order.attendee = Attendee.find(params[:attendee_id])

    respond_to do |format|
      if @order.save
        format.html { redirect_to [@order.attendee.trip, @order.attendee, @order], notice: 'Your order has been accepted' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to [@order.attendee.trip, @order.attendee, @order], notice: 'Your order has been updated' }
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
end
