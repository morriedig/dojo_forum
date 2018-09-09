class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user    
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    
    redirect_to user_path(@user)
  end
  

  def friend_ship
    # 找出user
    @friend = User.find(params[:id])
    current_user.update_ship(@friend)
    current_user.reload
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :image, :intro)
  end
end
