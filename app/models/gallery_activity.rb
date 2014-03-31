class GalleryActivity < Activity
  def email
    actor.email
  end

  def gallery_name
    target.name
  end
end
