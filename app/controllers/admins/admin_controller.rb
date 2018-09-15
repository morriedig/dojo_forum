class Admins::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_role

  private

  def check_role
    if !current_user.admin?
      redirect_to posts_path
    end
  end
end