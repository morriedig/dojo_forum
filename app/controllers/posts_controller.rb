class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    post_permission = lambda do |post|
      return true if post.user === current_user
      return true if post.post_permission === 1
      return true if current_user && post.post_permission === 2 && post.user.friended.include?(current_user)
      return false
    end

    @post_categories = PostCategory.includes(:posts, :posts => [:user, :loved_users]).where(:posts => { post_state: "publish" })
    if params[:category_id]
      @post_category = PostCategory.includes(:posts => [:user] ).find(params[:category_id])
      if params[:sort] == "most_reply"
        instance_variable_set("@post#{@post_category.id}", Kaminari.paginate_array( @post_category.posts.order_most_reply.includes(:user, :replies, :post_categories, :collection_posts).select(&post_permission)).page(params[:page]).per(20) )
      elsif params[:sort] == "latest_reply"
        instance_variable_set("@post#{@post_category.id}", Kaminari.paginate_array( @post_category.posts.order_latest_reply.includes(:user, :replies, :post_categories, :collection_posts).select(&post_permission)).page(params[:page]).per(20) )
      elsif params[:sort] == "most_viewed"
        instance_variable_set("@post#{@post_category.id}", Kaminari.paginate_array( @post_category.posts.order_most_viewed.includes(:user, :replies, :post_categories, :collection_posts).select(&post_permission)).page(params[:page]).per(20) )
      else
        instance_variable_set("@post#{@post_category.id}", Kaminari.paginate_array( @post_category.posts.includes(:user, :replies, :post_categories, :collection_posts).select(&post_permission)).page(params[:page]).per(20) )
      end
    else
      if params[:sort] == "most_reply"
        @post_categories.includes(:posts).each do | post_category |
          instance_variable_set("@post#{post_category.id}",Kaminari.paginate_array( post_category.posts.order_most_reply.includes(:user, :replies, :post_categories, :collection_posts).select(&post_permission)).page(params[:page]).per(20) )
        end
        @posts = Kaminari.paginate_array(Post.includes(:user, :loved_users , :replies).order_most_reply.select(&post_permission)).page(params[:page]).per(20)
      elsif params[:sort] == "latest_reply"
        @post_categories.includes(:posts).each do | post_category |
          instance_variable_set("@post#{post_category.id}", Kaminari.paginate_array( post_category.posts.order_latest_reply.includes(:user, :replies, :post_categories, :collection_posts).select(&post_permission)).page(params[:page]).per(20) )
        end
        @posts = Kaminari.paginate_array(Post.includes(:user, :loved_users , :replies).order_latest_reply.select(&post_permission)).page(params[:page]).per(20)
      elsif params[:sort] == "most_viewed"
        @post_categories.includes(:posts).each do | post_category |
          instance_variable_set("@post#{post_category.id}", Kaminari.paginate_array( post_category.posts.order_most_viewed.includes(:user, :replies, :post_categories, :collection_posts).select(&post_permission)).page(params[:page]).per(20) )
        end
        @posts = Kaminari.paginate_array(Post.includes(:user, :loved_users , :replies).order_most_viewed.select(&post_permission)).page(params[:page]).per(20)
      else
        @post_categories.includes(:posts).each do | post_category |
          instance_variable_set("@post#{post_category.id}", Kaminari.paginate_array(post_category.posts.published.includes(:user, :replies, :post_categories, :collection_posts).select(&post_permission)).page(params[:page]).per(20) )
        end
        @posts = Kaminari.paginate_array(Post.includes(:user, :loved_users , :replies).published.select(&post_permission)).page(params[:page]).per(20)
      end
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

  def feed
    @user_num = User.size
    @post_num = Post.size
    @reply_num = Reply.size
    @hot_post = Post.order_most_reply.limit(10)
    @hot_user = User.hot_user.limit(10)
  end
  
  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :post_state, :post_permission, :user_id, post_category_ids: [])
  end
end
