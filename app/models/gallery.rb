class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many :images, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true
end
