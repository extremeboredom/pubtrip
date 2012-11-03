class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
  	redirect_to login_url, :alert => "You must be logged in to access this page."
  end
end
