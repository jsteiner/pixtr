class Comment < ActiveRecord::Base
  paginates_per 2
  belongs_to :user
  belongs_to :image
  has_many :activities, as: :subject, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true

  def self.recent
    order(created_at: :desc)
  end

  def self.paginated(page)
    recent.page(page).includes(:user)
  end
end
