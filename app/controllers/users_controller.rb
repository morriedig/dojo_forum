class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.includes(:love_posts, :posts, :replies, :collection_posts, :collection_posts => [:user] , :replies => [:post], :posts => [:loved_users]).find(params[:id])
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
    @old_state = current_user.get_old_state(@friend)
    current_user.update_ship(@friend)
    current_user.reload
  end

  def remove_friendship
    @friend = User.find(params[:id])
    friendship = @friend.friendships.find_by(friend_id: current_user.id)
    friendship.destroy
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :image, :intro)
  end
end
