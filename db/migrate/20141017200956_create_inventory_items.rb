class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.string :name
      t.date :on
      t.text :description
      t.integer :cost
      t.integer :value
      t.timestamps
    end
  end
end
