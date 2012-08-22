class PubsController < ApplicationController
  # GET /pubs
  # GET /pubs.json
  def index
    @pubs = Pub.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pubs }
    end
  end

  # GET /pubs/1
  # GET /pubs/1.json
  def show
    @pub = Pub.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pub }
    end
  end

  # GET /pubs/new
  # GET /pubs/new.json
  def new
    @pub = Pub.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pub }
    end
  end

  # GET /pubs/1/edit
  def edit
    @pub = Pub.find(params[:id])
  end

  # POST /pubs
  # POST /pubs.json
  def create
    @pub = Pub.new(params[:pub])

    respond_to do |format|
      if @pub.save
        format.html { redirect_to @pub, notice: 'Pub was successfully created.' }
        format.json { render json: @pub, status: :created, location: @pub }
      else
        format.html { render action: "new" }
        format.json { render json: @pub.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pubs/1
  # PUT /pubs/1.json
  def update
    @pub = Pub.find(params[:id])

    respond_to do |format|
      if @pub.update_attributes(params[:pub])
        format.html { redirect_to @pub, notice: 'Pub was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pub.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pubs/1
  # DELETE /pubs/1.json
  def destroy
    @pub = Pub.find(params[:id])
    @pub.destroy

    respond_to do |format|
      format.html { redirect_to pubs_url }
      format.json { head :no_content }
    end
  end
end
