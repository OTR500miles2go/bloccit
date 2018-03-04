class CommentsController < ApplicationController
  # To ensure guest users can not create comments
  before_action :require_sign_in

  # To ensure unauthorized users are not permitted to delete comments.
  before_action :authorize_user, only: [:destroy]
  
  def create
  # Use post_id to find the correct post. Use comment_params to create new comment. Assign the comment's user to current_user which returns the signed-in user instace.
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
  # Redirect to posts show: display success message.
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment failed to save."
  # Redirect to posts show: display failure message.
      redirect_to [@post.topic, @post]
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@post.topic, @post]
    end
  end

  private
  
  # Use private method to white list the parameters needed to create comments.
  def comment_params
    params.require(:comment).permit(:body)
  end

  # Allow comment owner or admin user to delete the comment. Redirect unauthorized users to the post show view.
  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end  
end