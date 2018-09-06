class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    render :json => @post
  end

  def create
    @post = current_user.posts.create(post_params)
  end

  def edit
    @post = Post.find(params[:id])
    render :json => @post
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.update(post_params)      
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :post_state, :post_permission, :user_id, post_category_ids: [])
  end
end
