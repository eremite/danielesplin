require 'exifr/jpeg'
class PhotoBatch

  include ActiveModel::Model

  attr_accessor :images, :user, :errors

  def save
    self.errors = []
    images.each do |image|
      photo = user.photos.new(image: image)
      photo.at = Time.zone.parse(EXIFR::JPEG.new(image.open).date_time.to_s.first(20))
      self.errors << photo.errors.full_messages unless photo.save
    end
    true
  end

end
