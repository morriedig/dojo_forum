class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @post_categories = PostCategory.all
    if params[:category_id]
      @posts = PostCategory.find(params[:category_id]).posts.page(params[:page]).per(20)
    else
      @posts = Post.all.page(params[:page]).per(20)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    params[:post][:post_category_ids].compact.each do | category_id |
      puts category_id
      @post.join_posts.create(:post_category_id => category_id.to_i )
    end
    redirect_to "index"
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :post_state, :user_id, {:post_category_ids => []}, post_categories_attributes: [:title])
  end
end
