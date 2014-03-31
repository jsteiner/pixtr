class CommentActivity < Activity
  def email
    actor.email
  end

  def image
    target
  end

  def image_name
    image.name
  end
end
