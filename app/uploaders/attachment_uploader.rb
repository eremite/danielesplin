# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  storage :fog

  def store_dir
    "system/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
