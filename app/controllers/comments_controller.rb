class CommentsController < ApplicationController
  def create
    image = Image.find(params[:image_id])
    comment = image.comments.new(comment_params)

    if comment.save
      current_user.notify_followers(comment, image, "CommentActivity")
      redirect_to image, notice: "Commented successfully"
    else
      redirect_to image, alert: "Can not comment with an empty comment"
    end
  end

  private

  def comment_params
    params.
      require(:comment).
      permit(:body).
      merge(user_id: current_user.id)
  end
end
