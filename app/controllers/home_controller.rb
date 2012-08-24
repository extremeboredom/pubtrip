class HomeController < ApplicationController
  def index
  	@trips = Trip.where("date >= ?", Date.today).order("date")


  end
end
