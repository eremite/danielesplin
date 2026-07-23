class Entry < ApplicationRecord

  acts_as_taggable_on :entry_tags

  belongs_to :user
  belongs_to :creator, class_name: 'User', optional: true, default: -> { Current.user }

  validates :body, presence: true, on: :update

  paginates_per 7

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :before, ->(ends_at) { where(arel_table[:at].lteq(ends_at)) }

  def self.tags
    taggings = ActsAsTaggableOn::Tagging.where(context: 'entry_tags')
    ActsAsTaggableOn::Tag.joins(:taggings).merge(taggings).order(taggings_count: :desc).distinct
  end

  def after_create_redirect_url
    if at.to_date.today? && user.parent? && creator.parent?
      [:entries, { entry_search: { on_this_day: 1, user_id: user.id } }]
    else
      [:entries, { user_id: user.id }]
    end
  end

  def suggested_tags
    self.class.tags.where.not(id: entry_tag_ids)
  end

  def update_period_cache!
    return unless entry_tags.map(&:name).include?('period')
    period_started_on = Rails.cache.read('period_started_on')
    return unless period_started_on.nil? || at.to_date.after?(period_started_on)
    Rails.cache.write('period_started_on', at.to_date, expires_in: 40.days)
    Rails.cache.write('period_average_length', average_period_length, expires_in: 40.days)
  end

  private

  def average_period_length(limit: 12)
    tagged_ats = user.entries.tagged_with('period', on: :entry_tags).order(at: :desc).limit(limit + 1).pluck(:at)
    return 0 if tagged_ats.size < 2
    periods_in_days = tagged_ats.reverse.each_cons(2).map do |earlier, later|
      (later.to_date - earlier.to_date).to_i
    end
    (periods_in_days.sum / periods_in_days.size.to_f).round
  end

end
