class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def friend_ship
    @user = User.find(params[:id])
    if current_user.add_friend?(@user)
      puts "-/?????"
      @friendship = current_user.friendships.find_by(friend_id: @user.id)
      @friendship.destroy
    elsif current_user.added_friend?(@user)
      puts "====="
      @friendship = @user.friendships.find_by(friend_id: current_user.id)
      puts @friendship.inspect
      case @friendship.friend_state
      when "viewed"
        puts "viewed"
        @friendship.friend_state = "friend"
        @friendship.save
      when "inviting"
        @friendship.friend_state = "friend"
        puts @friendship.inspect
        @friendship.save
      when "friend"
        @friendship.destroy
      else
        puts "系統有誤，請通知管理員"
      end
    else
      @friendship = current_user.friendships.create(friend_id: params[:id].to_i , friend_state: "inviting")
    end
  end
end
