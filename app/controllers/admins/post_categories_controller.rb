class Admins::PostCategoriesController < ApplicationController
  # 這邊需要讓全部後台共用，之後可改寫
  before_action :authenticate_user!

  def index
    @post_categories = PostCategory.all
    @post_category = PostCategory.new
    @users = User.all
  end

  def create
    @post_category = PostCategory.create(post_category_params)
    # 之後要寫判斷失敗的狀況
  end

  def destroy
    find_post_category
    @post_category.destroy
  end

  private

  def find_post_category
    @post_category = PostCategory.find(params[:id])
  end

  def post_category_params
    params.require(:post_category).permit(:title)
  end
  
end
