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

  def edit
    @reply = Reply.find(params[:id])
  end

  def update
    @reply = Reply.find(params[:id])
    @reply.update(reply_params)
  end
  

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
  
end
