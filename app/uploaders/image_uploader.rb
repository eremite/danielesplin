# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage Rails.env.production? ? :fog : :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  def store_dir
    "system/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end


  # Create different versions of your uploaded files:
  version :small, if: :generate_versions? do
    process :resize_to_fit => [120, 120]
  end
  version :medium, if: :generate_versions? do
    process :resize_to_fit => [480, 480]
  end
  version :large, if: :generate_versions? do
    process :resize_to_fit => [1024, 1024]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process :extract_at
  process :rotate

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private

  def generate_versions?(photo)
    model.skip_versioning != '1'
  end

  def extract_at
    manipulate! do |img|
      date = img['EXIF:DateTimeOriginal'].to_s.squish
      if date.present?
        begin
          model.at = Time.zone.parse(date.sub(':', '-').sub(':', '-'))
        rescue ArgumentError, TypeError
          Rails.logger.error "#{date} is an invalid date."
        end
      end
      img
    end
  end

  def rotate
    manipulate! do |img|
      if model.rotate.present?
        case model.rotate
        when 'left'
          img.rotate '-90'
        when 'right'
          img.rotate '+90'
        end
      else
        img.auto_orient
      end
      img
    end
  end

end
