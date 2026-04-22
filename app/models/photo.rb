class Photo < ApplicationRecord

  acts_as_taggable_on :photo_tags

  has_one_attached :image

  belongs_to :user, default: -> { Current.user }
  belongs_to :entry, optional: true
  has_many :post_photos, dependent: :destroy
  has_many :posts, through: :post_photos
  has_many :inventory_item_photos, dependent: :destroy
  has_many :inventory_items, through: :inventory_item_photos

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :created_at_desc, -> { order(arel_table[:created_at].desc) }

  before_validation :handle_hidden
  before_destroy :purge_image
  after_save :auto_assign_posts, if: ->(photo) { photo.post_ids.blank? && !photo.hidden? }

  def self.unblogged
    includes(:post_photos).where(post_photos: { photo_id: nil })
  end

  def self.tags
    taggings = ActsAsTaggableOn::Tagging.where(context: 'photo_tags')
    ActsAsTaggableOn::Tag.joins(:taggings).merge(taggings).order(taggings_count: :desc).distinct
  end

  def suggested_tags
    self.class.tags.where.not(id: photo_tag_ids)
  end

  private

  def handle_hidden
    return unless hidden?

    self.posts = []
    self.post_ids = []
  end

  def auto_assign_posts
    self.posts = Post.where(at: created_at.all_day)
  end

  def purge_image
    image.purge
  end

end
