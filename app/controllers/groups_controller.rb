class GroupsController < ApplicationController
  before_filter :require_login

  def new
    @group = Group.new
  end
end
