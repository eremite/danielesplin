class Photo < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  attr_accessor :rotate

  attr_protected :id

  belongs_to :user
  belongs_to :entry

  scope :at_asc, order(arel_table[:at].asc)
  scope :at_desc, order(arel_table[:at].desc)
  scope :created_at_desc, order(arel_table[:created_at].desc)

  before_save :reprocess, if: lambda { |p| p.rotate.present? }

  def self.unblogged
    excluded_ids = []
    Entry.all.each do |entry|
      excluded_ids += entry.photos.map(&:id)
    end
    Photo.where(arel_table[:id].not_in(excluded_ids))
  end

  private

  def reprocess
    image.recreate_versions!
  end

end
