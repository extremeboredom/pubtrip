class GroupsController < ApplicationController
  before_filter :require_login

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    @group.owner = current_user

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created' }
      else
        format.html { render action: :new }
      end
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = current_user.owned_groups
  end
end
