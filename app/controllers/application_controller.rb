class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_current_user

protected
  def set_current_user
    @current_user ||= Moviegoer.find_by_id(session[:user_id])
  end
end
