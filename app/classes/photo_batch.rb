require 'exifr/jpeg'
class PhotoBatch

  include ActiveModel::Model

  attr_accessor :images, :user, :errors

  def save
    self.errors = []
    images.each do |image|
      next if image.blank?
      photo = user.photos.new(image: image)
      photo.image.open { |tempfile| photo.at = extract_time(tempfile) }
      self.errors << photo.errors.full_messages unless photo.save
    end
    true
  end

  private

  def extract_time(file)
    begin
      Time.zone.parse(EXIFR::JPEG.new(file).date_time.to_s.first(20))
    rescue EXIFR::MalformedJPEG
      Time.current
    end
  end

end
