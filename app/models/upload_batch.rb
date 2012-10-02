class UploadBatch
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :description, :images


  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def save!
    images.to_a.each do |image|
      Photo.create!({
        description: description,
        image: image,
      })
    end
  end

end
