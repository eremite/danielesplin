class CreateSavedFileCategories < ActiveRecord::Migration
  def change
    create_table :saved_file_categories do |t|
      t.string :name
      t.timestamps
    end
  end
end
