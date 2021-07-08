class PhotoBatch

  include ActiveModel::Model

  attr_accessor :images, :user, :errors

  def save
    self.errors = []
    images.each do |image|
      photo = user.photos.new(image: image)
      self.errors << photo.errors.full_messages unless photo.save
    end
    true
  end

end
