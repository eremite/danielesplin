class Post < ApplicationRecord

  acts_as_taggable_on :post_tags

  has_many :comments, dependent: :destroy
  has_many :post_photos, dependent: :destroy
  has_many :photos, through: :post_photos

  before_create :auto_assign_photos

  validates :body, presence: true

  paginates_per 3

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :before, ->(ends_at) { where(arel_table[:at].lteq(ends_at)) }
  scope :past, -> { where(arel_table[:at].lteq(Time.zone.now)) }
  scope :future, -> { where(arel_table[:at].gt(Time.zone.now)) }

  def dated_title
    title.presence || I18n.l(at.to_date, format: '%B %Y')
  end

  def with_defaults
    latest_at = Post.order(at: :desc).first&.at || return
    next_at = latest_at.next_month.end_of_month
    self.at ||= next_at
    self.title ||= next_at.strftime('%B %Y')
    self
  end

  def self.tags
    taggings = ActsAsTaggableOn::Tagging.where(context: 'post_tags')
    ActsAsTaggableOn::Tag.joins(:taggings).merge(taggings).order(taggings_count: :desc).distinct
  end

  def suggested_tags
    self.class.tags.where.not(id: post_tag_ids)
  end

  private

  def auto_assign_photos
    self.photos = Photo.where(hidden: false, created_at: at.all_day) if at.present?
    true
  end

end
