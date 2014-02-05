# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  storage Rails.env.production? ? :fog : :file

  def store_dir
    "system/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
