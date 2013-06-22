class CreateEntryPhotos < ActiveRecord::Migration
  def change
    create_table :entry_photos do |t|
      t.belongs_to :entry
      t.belongs_to :photo
      t.timestamps
    end
    add_index :entry_photos, :entry_id
    add_index :entry_photos, :photo_id
  end
end
