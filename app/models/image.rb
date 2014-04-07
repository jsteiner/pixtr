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
    tags.pluck(:name).join(", ")
  end

  def tag_list=(tag_string)
    self.tags = Tag.from_tag_list(tag_string)
  end
end
