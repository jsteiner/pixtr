class ImagesController < ApplicationController
  respond_to :html

  def new
    @gallery = find_gallery
    @image = Image.new
  end

  def create
    @gallery = find_gallery
    @image = @gallery.images.create(image_params)

    respond_with @image, location: @gallery
  end

  def show
    @image = Image.find(params[:id])
    @comment = Comment.new
    @comments = @image.comments.paginated(params[:page])
    @tags = @image.tags
  end

  def edit
    @image = find_image
    @groups = current_user.groups
  end

  def update
    @image = find_image
    @image.update(image_params)
    @groups = current_user.groups

    respond_with @image
  end

  def destroy
    image = find_image
    image.destroy
    redirect_to image.gallery
  end

  private

  def find_image
    current_user.images.find(params[:id])
  end

  def find_gallery
    current_user.galleries.find(params[:gallery_id])
  end

  def image_params
    params.require(:image).permit(
      :name,
      :url,
      :description,
      :tag_list,
      group_ids: []
    )
  end
end
