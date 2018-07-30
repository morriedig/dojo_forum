class RepliesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @reply =  @post.replies.new(reply_params)
    @reply.user_id = current_user.id
    @reply.save
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
  
end
