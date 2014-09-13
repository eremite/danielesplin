class Entry < ActiveRecord::Base

  acts_as_taggable

  belongs_to :user
  has_many :comments
  has_many :entry_photos
  has_many :photos, through: :entry_photos

  before_create :auto_assign_photos

  validates :body, presence: true

  paginates_per 25

  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :blog, -> { where(public: true) }
  scope :journal, -> { where(public: false) }
  scope :published, lambda { |*b| where(!!b.first ? arel_table[:at].lt(Time.zone.now) : arel_table[:at].gt(Time.zone.now) ) }
  scope :before, -> (ends_at) { where(arel_table[:at].lteq(ends_at)) }


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
