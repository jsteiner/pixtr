class GroupsController < ApplicationController
  before_action :authorize, except: [:show]

  def index
    @groups = current_user.groups
  end

  def show
    @group = find_group
    @images = find_images(@group)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      group_membership = current_user.join @group
      notify_followers(group_membership, group)
      redirect_to @group
    else
      render :new
    end
  end

  private

  def find_group
    Group.find(params[:id])
  end

  def find_images(group)
    group.images.includes(gallery: [:user])
  end

  def group_params
    params.require(:group).permit(
      :name,
      :description
    )
  end
end
