class FixImageProcessingInPhotos < ActiveRecord::Migration

  def self.up
    remove_column :photos, :boolean
    add_column :photos, :image_processing, :boolean
  end

  def self.down
    remove_column :photos, :image_processing
    add_column :photos, :boolean, :string
  end

end
