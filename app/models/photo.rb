class Photo < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  attr_accessor :rotate, :skip_versioning

  belongs_to :user
  belongs_to :entry
  has_many :entry_photos
  has_many :entries, through: :entry_photos

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :created_at_desc, -> { order(arel_table[:created_at].desc) }

  before_validation :auto_assign_entries, if: ->(photo) { photo.entry_ids.blank? }
  before_validation :handle_hidden
  after_create :reprocess
  after_update :reprocess, if: lambda { |p| p.rotate.present? }


  def self.unblogged
    includes(:entry_photos).where( :entry_photos => { :photo_id => nil } )
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

  def entry_options_for_select
    [
      ['Default', nil],
      ['None (hidden)', 0],
    ] + Entry.public.at_desc.limit(50).map { |e| [e.dated_title, e.id] }
  end

  def reprocess
    image.recreate_versions! if image?
  end
  handle_asynchronously :reprocess

  def to_jq_upload
    {
      'name' => image.filename || "Photo#{id}",
      'size' => image.size,
      'url' => image.url,
      'thumbnailUrl' => image.url(:small),
      'deleteUrl' => "/photos/#{id}",
      'deleteType' => 'DELETE'
    }
  end


  private

  def handle_hidden
    if hidden?
      self.entries = []
      self.entry_ids = []
    end
  end

  def auto_assign_entries
    if at.present?
      self.entries = Entry.public.where(at: at.beginning_of_day..at.end_of_day)
    end
  end

end
