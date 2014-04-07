class Image < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments, dependent: :destroy

  has_many :taggings
  has_many :tags, through: :taggings

  has_many :likes, as: :likable, dependent: :destroy

  has_many :group_images, dependent: :destroy
  has_many :groups, through: :group_images

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true

  def user
    gallery.user
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(tag_string)
    tags = tag_string.split(",").map do |tag_name|
      Tag.find_or_create_by(name: tag_name.strip.downcase)
    end
    self.tags = tags
  end
end
