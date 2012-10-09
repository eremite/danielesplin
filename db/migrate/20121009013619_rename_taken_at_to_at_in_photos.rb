class RenameTakenAtToAtInPhotos < ActiveRecord::Migration
  def up
    rename_column :photos, :taken_at, :at
  end

  def down
    rename_column :photos, :at, :taken_at
  end
end
