class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.datetime :taken_at
      t.text :description
      t.timestamps
    end
  end
end
