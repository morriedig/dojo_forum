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
    current_user.reload
  end
end
