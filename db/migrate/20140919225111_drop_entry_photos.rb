class DropEntryPhotos < ActiveRecord::Migration
  def change
    drop_table :entry_photos do |t|
      t.belongs_to :entry
      t.belongs_to :photo
      t.timestamps
    end
  end
end
