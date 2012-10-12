class Photo < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  attr_protected :id

  belongs_to :user

  scope :oldest_first, order(arel_table[:at].asc)

end
