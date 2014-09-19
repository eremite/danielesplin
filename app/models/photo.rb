class Photo < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  attr_accessor :skip_versioning

  belongs_to :user
  belongs_to :entry
  has_many :post_photos
  has_many :posts, through: :post_photos

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :created_at_desc, -> { order(arel_table[:created_at].desc) }

  before_validation :handle_hidden
  after_save :auto_assign_entries, if: ->(photo) { photo.post_ids.blank? }


  def self.unblogged
    includes(:post_photos).where( :post_photos => { :photo_id => nil } )
  end


  def google_plus_remote_image_url=(value)
    if value.present?
      parts = value.split('/')
      parts[-2] = 'd'
      self.remote_image_url = parts.join('/')
    end
  end

  def google_plus_remote_image_url
    remote_image_url
  end

  def process
    image.recreate_versions! if image?
  end

  def resize_url(size)
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

  def auto_assign_entries
    self.posts = Post.where(at: created_at.beginning_of_day..created_at.end_of_day)
  end

end
