require 'exifr/jpeg'
class PhotoBatch

  include ActiveModel::Model

  attr_accessor :images, :user, :errors

  def save
    self.errors = []
    images.each do |image|
      next if image.blank?
      photo = user.photos.new(image: image)
      photo.image.open { |tempfile| photo.at = extract_time(tempfile, photo.image.blob.filename.to_s) }
      self.errors << photo.errors.full_messages unless photo.save
    end
    true
  end

  private

  def extract_time(file, filename)
    exif_time(file) || filename_time(filename) || Time.current
  end

  def exif_time(file)
    Time.zone.parse(EXIFR::JPEG.new(file).date_time.to_s.first(20))
  rescue EXIFR::MalformedJPEG
    nil
  end

  def filename_time(filename)
    match = filename.match(/.*(?<date>\d{8})_(?<time>\d{6}).*/)
    Time.zone.strptime("#{match[:date]} #{match[:time]}", '%Y%m%d %H%M%S') rescue nil
  end

end
