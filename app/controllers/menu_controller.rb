class MenuController < ApplicationController

  # GET /pubs/1/menu
  def show
    @pub = Pub.find(params[:id])
  end

  def new
  end

  def edit
  end
end
