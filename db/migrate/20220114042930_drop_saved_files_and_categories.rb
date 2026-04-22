class DropSavedFilesAndCategories < ActiveRecord::Migration[6.1]

  def change
    drop_table :saved_files do |t|
      t.belongs_to :user, index: true
      t.text :description
      t.string :attachment
      t.timestamps
    end
    drop_table :saved_file_categories do |t|
      t.string :name
      t.timestamps
    end
  end

end
