class Photo < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  attr_protected :id

  belongs_to :user

  scope :oldest_first, order(arel_table[:at].asc)

  before_save :extract_at

  private

  def extract_at
    if image?
      image.manipulate! do |img|
        date = img['EXIF:DateTimeOriginal'].to_s.squish
        if date.present?
          begin
            self.at = Time.zone.parse(date.sub(':', '-').sub(':', '-'))
          rescue ArgumentError, TypeError
            logger.error "#{date} is an invalid date."
          end
          img
        end
      end
    end
  end

end
