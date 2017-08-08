class CommentController < ApplicationController
  def create
    newComment = Comment.new
    newComment.content = params[:content]
    newComment.post_id = params[:post_id]
    newComment.user = current_user
    newComment.save
    
    redirect_to :back
  end

  def destroy
    destroyComment = Comment.find(params[:comment_id])
    destroyComment.destroy
    
    redirect_to :back
  end

  def update
    updateComment = Comment.find(params[:comment_id])
    updateComment.content = params[:content]
    updateComment.save
    
    redirect_to :back
  end
end
