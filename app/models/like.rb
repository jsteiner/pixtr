class Like < ActiveRecord::Base
  belongs_to :image
  belongs_to :user

  validates :user, presence: true, uniqueness: { scope: :image }
  validates :image, presence: true
end
