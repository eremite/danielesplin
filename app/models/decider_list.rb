class DeciderList < ApplicationRecord

  has_many :items, class_name: "DeciderListItem", dependent: :destroy

  def pick
    available_items = items.where(picked_at: nil)
    if available_items.empty?
      available_items = items
      available_items.update_all(picked_at: nil)
    end
    item = available_items.to_a.sample
    item.touch(:picked_at)
    item
  end

end
