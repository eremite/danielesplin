class Entry < ApplicationRecord

  acts_as_taggable_on :entry_tags

  belongs_to :user
  belongs_to :creator, class_name: 'User', optional: true

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
    # return [:entries] if at < 3.days.ago || creator.child?
    # return [:entries, { ends_on: 5.years.ago.to_date, random: 1 }] if creator.father?
    child = nil
    User.where(role: 'baby').each do |user|
      if user.entries.where(at: at.all_day).blank?
        entry = Entry.create!(at: Time.current, user: user, creator: creator)
        return [:edit, entry]
      end
    end
    [:entries]
  end

  def suggested_tags
    self.class.tags.where.not(id: entry_tag_ids)
  end

end
