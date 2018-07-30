class RepliesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @reply =  @post.replies.new(reply_params)
    @reply.user_id = current_user
    @reply.save
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
  
end
