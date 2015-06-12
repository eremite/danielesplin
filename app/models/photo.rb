class Photo < ActiveRecord::Base

  acts_as_taggable_on :photo_tags

  mount_uploader :image, ImageUploader

  attr_accessor :skip_versioning

  belongs_to :user
  belongs_to :entry
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


  def google_plus_remote_image_url=(value)
    self.remote_image_url = value.to_s.sub(/=w(\d+)-h(\d+)/, '=w9999-h9999').presence
  end

  def google_plus_remote_image_url
    remote_image_url
  end

  def process
    image.recreate_versions! if image?
  end

  def resize_url(size)
    return "#{size}.jpg" if Rails.env.development?
    params = {
      key: Rails.application.config.embedly_key,
      url: image.url,
    }
    params[:height] =
      case size
      when :small
        200
      when :medium
        480
      when :large
        1024
      end
    "https://i.embed.ly/1/display/resize?#{params.to_param}"
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
