class GalleryActivity < Activity
  def email
    subject.user.email
  end

  def gallery_name
    subject.name
  end
end
