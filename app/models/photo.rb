class Photo < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  attr_accessor :rotate

  attr_protected :id

  belongs_to :user
  belongs_to :entry

  scope :at_asc, order(arel_table[:at].asc)
  scope :at_desc, order(arel_table[:at].desc)

  before_save :reprocess, if: lambda { |p| p.rotate.present? }


  private

  def reprocess
    image.recreate_versions!
  end

end
