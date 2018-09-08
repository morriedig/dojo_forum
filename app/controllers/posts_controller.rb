class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @post_categories = PostCategory.includes(:posts).where(:posts => { post_state: "publish" })
    if params[:category_id]
      @post_category = PostCategory.includes(:posts => [:user] ).find(params[:category_id])
      instance_variable_set("@post#{@post_category.id}", @post_category.posts.includes(:user, :replies, :post_categories, :collection_posts).page(params[:page]).per(20) )
    else
      @post_categories.includes(:posts, :posts => [:user, :replies, :collection_posts]).each do | post_category |
        instance_variable_set("@post#{post_category.id}",post_category.posts.includes(:user, :replies, :post_categories, :collection_posts).page(params[:page]).per(20) )
      end
      @posts = Post.includes(:user, :post_categories , :replies).published.page(params[:page]).per(20)
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.includes(:replies).find(params[:id])
    @post.add_viewed
    @replies = @post.replies.page(params[:page]).per(20)
  end

  def edit
    find_post   
  end

  def update
    find_post
    if @post.own?(current_user)
      @post.update(post_params)
    end
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
    if current_user.admin? || @post.own?(current_user)
      @post.destroy
    end
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
