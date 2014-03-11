class RandomGalleriesController < ApplicationController
  def show
    @gallery = Gallery.all.sample
    render 'galleries/show'
  end
end
