class Photo < ApplicationRecord

  acts_as_taggable_on :photo_tags

  has_one_attached :image

  belongs_to :user
  belongs_to :entry, optional: true
  has_many :post_photos
  has_many :posts, through: :post_photos
  has_many :inventory_item_photos
  has_many :inventory_items, through: :inventory_item_photos

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :created_at_desc, -> { order(arel_table[:created_at].desc) }

  before_validation :handle_hidden
  after_save :auto_assign_posts, if: ->(photo) { photo.post_ids.blank? && !photo.hidden? }


  def self.unblogged
    includes(:post_photos).where( :post_photos => { :photo_id => nil } )
  end


  def to_jq_upload
    {
      'name' => image.filename || "Photo#{id}",
      'size' => image.size,
      'image_url' => image.url,
      'photo_url' => "/photos/#{id}",
    }
  end


  private

  def handle_hidden
    if hidden?
      self.posts = []
      self.post_ids = []
    end
  end

  def auto_assign_posts
    self.posts = Post.where(at: created_at.beginning_of_day..created_at.end_of_day)
  end

end
