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
end
