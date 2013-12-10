class AddImageProcessingToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :boolean, :string
  end
end
