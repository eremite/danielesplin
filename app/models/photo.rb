class Photo < ApplicationRecord

  acts_as_taggable_on :photo_tags

  has_one_attached :image

  belongs_to :user, default: -> { Current.user }
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
  before_destroy :purge_image

  def self.search(params)
    photos = Photo.all
    photos =
      case params[:order]
      when "created_at_desc"
        photos.created_at_desc
      when "updated_at_desc"
        photos.order(updated_at: :desc)
      else
        photos.at_desc
      end
    if params[:ends_on].present?
      ends_on = Date.parse(params[:ends_on] || Date.current.to_s).end_of_day
      photos = photos.where(at: Time.at(0)..ends_on)
    end
    photos = photos.tagged_with(params[:tag], on: :photo_tags) if params[:tag].present?
    if params[:term].present?
      photos = photos.where(arel_table[:description].matches("%#{params[:term].to_s.downcase}%"))
    end
    photos = photos.where(description: [nil, ""]) if params[:nondescript].to_i.nonzero?
    photos = photos.includes(:post_photos).where(post_photos: { photo_id: nil }) if params[:unblogged].to_i.nonzero?
    photos.page(params[:page]).per(30)
  end

  def self.order_options
    [["Photo Date", :at_desc], ["Date Uploaded", :created_at_desc], ["Last Modified", :updated_at_desc]]
  end

  def self.unblogged
    includes(:post_photos).where( :post_photos => { :photo_id => nil } )
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
    if hidden?
      self.posts = []
      self.post_ids = []
    end
  end

  def auto_assign_posts
    self.posts = Post.where(at: created_at.beginning_of_day..created_at.end_of_day)
  end

  def purge_image
    image.purge
  end

end
