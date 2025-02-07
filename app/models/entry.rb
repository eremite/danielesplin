class Entry < ApplicationRecord

  acts_as_taggable_on :entry_tags

  belongs_to :user
  belongs_to :creator, class_name: 'User', optional: true, default: -> { Current.user }

  validates :body, presence: true, on: :update

  paginates_per 7

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :before, -> (ends_at) { where(arel_table[:at].lteq(ends_at)) }

  def self.tags
    taggings = ActsAsTaggableOn::Tagging.where(context: 'entry_tags')
    ActsAsTaggableOn::Tag.joins(:taggings).merge(taggings).order(taggings_count: :desc).distinct
  end

  def after_create_redirect_url
    if at.to_date.today? && user.parent? && creator.parent?
      [:new, :entry_batch]
    else
      [:entries, { user_id: user.id }]
    end
  end

  def suggested_tags
    self.class.tags.where.not(id: entry_tag_ids)
  end

end
