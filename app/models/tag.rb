class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :images, through: :taggings

  def self.search(search_params)
    query = search_params[:query]
    where("name ILIKE ?", "%#{query}%")
  end

  def self.from_tag_list(tag_string)
    tag_string.split(",").map do |tag_name|
      find_or_create_by(name: tag_name.strip.downcase)
    end
  end
end
