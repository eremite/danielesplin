class InventoryItemPhoto < ActiveRecord::Base
  belongs_to :inventory_item
  belongs_to :photo
end
