class AddDeletedToInventoryItems < ActiveRecord::Migration[6.1]

  def change
    add_column :inventory_items, :deleted_at, :datetime
  end

end
