class MembersController < ApplicationController
  before_filter :require_login

  def new
    @group = Group.find(params[:group_id])
    @member = Member.new

    respond_to do |format|
      if current_user == @group.owner
        format.html
      else
        format.html { redirect_to groups_path, notice: 'You do not have permission to add members to that group'}
      end
    end
  end

  def create
    @group = Group.find(params[:group_id])
    if current_user == @group.owner
      @member = Member.new(params[:member])
      @member.group = @group
      respond_to do |format|
        if @member.save
          format.html { redirect_to @group, notice: 'The member was successfully added' }
        else
          format.html { render action: :new }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to groups_path, notice: 'You do not have permission to add members to that group'}
      end
    end
  end
end
