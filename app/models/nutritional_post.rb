class NutritionalPost < ActiveRecord::Base

  validates :title, presence: true
  validates :bite, presence: true
  validates :slug, uniqueness: true

  before_validation :set_slug, on: :create

  scope :created_at_desc, lambda { order(arel_table[:created_at].desc) }
  scope :published, lambda { |*b| where(!!b.first ? arel_table[:published_at].lt(Time.zone.now) : arel_table[:published_at].gt(Time.zone.now) ) }


  def published?
    published_at.present? && !published_at.future?
  end


  private

  def set_slug
    self.slug = title.to_s.squish.parameterize
  end

end
