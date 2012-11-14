class AddEntryIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :entry_id, :integer
    add_index :photos, :entry_id
  end
end
