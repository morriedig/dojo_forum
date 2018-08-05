class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @post_categories = PostCategory.all
    if params[:category_id]
      @post_category = PostCategory.find(params[:category_id])
      @posts = @post_category.posts.page(params[:page]).per(1)
    else
      @post_categories.each do | post_category |
        instance_variable_set("@post#{post_category.id}",post_category.posts.page(params[:page]).per(1) )
      end
      @posts = Post.page(params[:page]).per(1)
    end
  end

  def new
    @post = Post.new
  end

  def show
    find_post
    @replies = @post.replies.page(params[:page]).per(20)
  end

  def edit
    find_post   
  end

  def update
    find_post
    @post.update(post_params)
    redirect_to root_path
  end

  def create
    # 之後需要寫判斷
    @post = current_user.posts.new(post_params)
    @post.save
    redirect_to posts_path
  end

  def destroy
    find_post
    @post.destroy
    if params[:show]
      redirect_to root_path
    end
  end
  
  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :post_state, :post_permission, :user_id, post_category_ids: [])
  end
end
