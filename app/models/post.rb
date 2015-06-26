class Post < ActiveRecord::Base

  acts_as_taggable_on :post_tags

  has_many :comments
  has_many :post_photos
  has_many :photos, through: :post_photos

  before_create :auto_assign_photos

  validates :body, presence: true

  paginates_per 7

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :before, -> (ends_at) { where(arel_table[:at].lteq(ends_at)) }
  scope :past, -> { where(arel_table[:at].lteq(Time.zone.now)) }
  scope :future, -> { where(arel_table[:at].gt(Time.zone.now)) }


  def title
    body.split(/\r?\n/).first.gsub(/[^\w\s\.\?,!]/, '').squish.first(50)
  end

  def dated_title
    "#{I18n.l(at.to_date)} #{title}"
  end


  private

  def auto_assign_photos
    if at.present?
      self.photos = Photo.where(hidden: false, created_at: at.beginning_of_day..at.end_of_day)
    end
    true
  end

end
