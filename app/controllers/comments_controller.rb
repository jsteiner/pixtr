class CommentsController < ApplicationController
  def create
    image = Image.find(params[:image_id])
    image.comments.create(comment_params)
    redirect_to image
  end

  private

  def comment_params
    params.
      require(:comment).
      permit(:body). # { "body" => "foo" }
      merge(user_id: current_user.id) # { "body" => "foo", "user_ud" => 1 }
  end
end
