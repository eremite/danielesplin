class InventoryItemSearch

  include ActiveModel::Model

  attr_accessor :ends_on, :deleted, :order, :page, :term, :tag, :inventory_items

  def self.order_options
    [['Purchase Date - Newest First', :on_desc], ['Purchase Date - Oldest First', :on_asc]]
  end

  def load
    self.ends_on = parse_date(ends_on) if ends_on.present?
    self.order ||= 'on_desc'
    self.inventory_items = find_inventory_items
    self
  end

  private

  def find_inventory_items
    results = InventoryItem.all
    results = deleted.to_i.nonzero? ? results.deleted : results.not_deleted
    results = order == 'on_asc' ? results.order(on: :asc) : results.on_desc
    results = results.before(ends_on.end_of_day) if ends_on.present?
    if term.present?
      t = "%#{term.to_s.downcase}%"
      results = results.where(
        InventoryItem.arel_table[:name].matches(t).or(InventoryItem.arel_table[:description].matches(t))
      )
    end
    results = results.tagged_with(tag, on: :inventory_item_tags) if tag.present?
    results.page(page)
  end

  def parse_date(date_string)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    Date.current
  end

end
