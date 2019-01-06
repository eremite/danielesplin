class InventoryItemPhoto < ApplicationRecord
  belongs_to :inventory_item
  belongs_to :photo
end
