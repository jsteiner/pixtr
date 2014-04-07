class ImageSearcher
  def initialize(search_params)
    @query = search_params[:query]
    @search_params = search_params
  end

  def images
    find_images_by_name_description_and_tags
  end

  private
  attr_reader :search_params, :query

  def find_images_by_name_description_and_tags
    Image.where(search_sql, query: "%#{query}%", image_ids: image_ids_for_tags)
  end

  def search_sql
    "name ILIKE :query OR description ILIKE :query OR id IN (:image_ids)"
  end

  def image_ids_for_tags
    Tagging.where(tag_id: tags).pluck(:image_id)
  end

  def tags
    Tag.search(search_params)
  end
end
