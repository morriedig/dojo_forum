class CollectionPostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @collection_post = current_user.collection_posts.find_by(post_id: params[:post_id])
    if @collection_post
      @collection_post.destroy
    else
      @collection_post = current_user.collection_posts.create(post_id: params[:post_id])
    end
  end

  def destroy
    @collection_post.find(params[:id])
    @collection_post.destroy
  end
  
  
end