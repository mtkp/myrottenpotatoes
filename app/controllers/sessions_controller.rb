class SessionsController < ApplicationController

  skip_before_action :set_current_user, only: :create

  def new
  end

  def create
    user = Moviegoer.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = user.id
    flash[:success] = "Logged in successfully!"
    @auth_hash = auth_hash
    render 'new'
    #redirect_to movies_path
  end

  def destroy
    session.delete(:user_id)
    flash[:info] = "Logged out successfully."
    redirect_to root_path
  end

protected
  def auth_hash
    request.env['omniauth.auth']
  end

end
