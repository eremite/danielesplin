class RemoveAttachmentImageFromPhotos < ActiveRecord::Migration
  def up
    remove_column :photos, :image_file_name
    remove_column :photos, :image_content_type
    remove_column :photos, :image_file_size
    remove_column :photos, :image_updated_at
  end

  def down
    add_column :photos, :image_updated_at, :datetime
    add_column :photos, :image_file_size, :integer
    add_column :photos, :image_content_type, :string
    add_column :photos, :image_file_name, :string
  end
end
