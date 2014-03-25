class FollowingRelationshipActivity < Activity
  def follower_email
    subject.follower.email
  end

  def followed_user_email
    subject.followed_user.email
  end
end
