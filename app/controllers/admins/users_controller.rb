class Admins::UsersController < Admins::AdminController

  def index
    @users = User.all
  end

  def show
    find_user
  end

  def change_role
    find_user
    if @user.admin?
      @user.role = "guset"
    else
      @user.role = "admin"
    end
    @user.save
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
