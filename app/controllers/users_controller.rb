class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def friend_ship
    # 找出user
    @friend = User.find(params[:id])
    current_user.update_ship(@friend)
    # if session[:user_id]
    # @current_user ||= User.find(session[:user_id])
    # end
    current_user.reload

    # redirect_to user_path(@friend)
  end
end
