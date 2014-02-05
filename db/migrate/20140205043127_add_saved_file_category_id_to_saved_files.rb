class AddSavedFileCategoryIdToSavedFiles < ActiveRecord::Migration
  def change
    add_column :saved_files, :saved_file_category_id, :integer
    add_index :saved_files, :saved_file_category_id
  end
end
