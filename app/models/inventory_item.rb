class InventoryItem < ApplicationRecord

  acts_as_taggable_on :inventory_item_tags

  has_many :inventory_item_photos
  has_many :photos, through: :inventory_item_photos

  validates :name, presence: true

  scope :on_desc, -> { order(arel_table[:on].desc) }
  scope :before, -> (ends_on) { where(arel_table[:on].lteq(ends_on)) }
  scope :deleted, -> { where.not(deleted_at: nil) }
  scope :not_deleted, -> { where(deleted_at: nil) }

  def self.tags
    taggings = ActsAsTaggableOn::Tagging.where(context: 'inventory_item_tags')
    ActsAsTaggableOn::Tag.joins(:taggings).merge(taggings).order(taggings_count: :desc).distinct
  end

  def self.order_options
    [["Purchase Date - Newest First", :on_desc], ["Purchase Date - Oldest First", :on_asc]]
  end

  def summary
    [name.presence, I18n.l(on).presence, inventory_item_tags.pluck(:name).join(', ')].compact.join(' - ')
  end

  def cost_in_dollars
    cost.to_i / 100.0
  end

  def cost_in_dollars=(amount)
    self.cost = amount.to_s.gsub(/[^-\d\.]/, '').to_f * 100
  end

  def value_in_dollars
    value.to_i / 100.0
  end

  def value_in_dollars=(amount)
    self.value = amount.to_s.gsub(/[^-\d\.]/, '').to_f * 100
  end

  def suggested_tags
    self.class.tags.where.not(id: inventory_item_tag_ids)
  end

end
