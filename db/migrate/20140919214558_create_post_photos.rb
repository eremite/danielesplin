class CreatePostPhotos < ActiveRecord::Migration
  def change
    create_table :post_photos do |t|
      t.belongs_to :post, index: true
      t.belongs_to :photo, index: true
      t.timestamps
    end
  end
end
