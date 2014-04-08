class User < ActiveRecord::Base
  include Clearance::User

  has_many :activities

  has_many :galleries, dependent: :destroy
  has_many :images, through: :galleries

  has_many :likes, dependent: :destroy, inverse_of: :user
  has_many :liked_images,
    through: :likes,
    source: :likable,
    source_type: 'Image'

  has_many :group_memberships, foreign_key: :member_id, dependent: :destroy
  has_many :groups, through: :group_memberships

  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: "FollowingRelationship",
    dependent: :destroy

  has_many :followed_users,
    through: :followed_user_relationships

  has_many :follower_relationships,
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship",
    dependent: :destroy

  has_many :followers,
    through: :follower_relationships

  def follow(other_user)
    followed_user_relationships.create(followed_user: other_user)
  end

  def unfollow(other_user)
    followed_users.destroy(other_user)
  end

  def following?(other_user)
    followed_user_ids.include? other_user.id
  end

  def join(group)
    group_memberships.create(group: group)
  end

  def leave(group)
    groups.destroy(group)
  end

  def like(target)
    likes.create(likable: target)
  end

  def unlike(target)
    like = likes.find_by(likeable: target)
    like.destroy
  end

  def likes?(target)
    likes.exists?(likable: target)
  end

  def member?(group)
    group_ids.include? group.id
  end

  def upgraded?
    stripe_id.present?
  end
end
