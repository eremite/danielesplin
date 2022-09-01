class Note < ApplicationRecord

  acts_as_taggable_on :note_tags

  belongs_to :user

  def self.tags
    taggings = ActsAsTaggableOn::Tagging.where(context: 'note_tags')
    ActsAsTaggableOn::Tag.joins(:taggings).merge(taggings).order(taggings_count: :desc).distinct
  end

  def suggested_tags
    self.class.tags.where.not(id: note_tag_ids)
  end

end
