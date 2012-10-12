class Photo < ActiveRecord::Base

  attr_protected :id

  belongs_to :user

  has_attached_file :image, {
    :styles => {
      :small => '120x120>',
      :medium => '480x480>',
      :large => '1024x1024>',
    },
  }.merge(Rails.application.config.paperclip_storage_options)

  scope :oldest_first, order(arel_table[:at].asc)

end
