class CreateInventoryItemPhotos < ActiveRecord::Migration
  def change
    create_table :inventory_item_photos do |t|
      t.belongs_to :inventory_item, index: true
      t.belongs_to :photo, index: true
      t.timestamps
    end
  end
end
