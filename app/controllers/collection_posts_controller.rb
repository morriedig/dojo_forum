class CollectionPostsController < ApplicationController

  def create
    @collection_post = current_user.collection_posts.find_by(post_id: params[:post_id])
    if @collection_post
      @collection_post.destroy
    else
      @collection_post = current_user.collection_posts.create(post_id: params[:post_id])
    end
  end
  
end