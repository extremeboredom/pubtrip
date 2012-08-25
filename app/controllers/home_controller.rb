class HomeController < ApplicationController
  def index
  	@trips = Trip.upcoming


  end
end
