class PasswordResetsController < ApplicationController
  def create
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated unless @user
  end

  def update
  end
end
