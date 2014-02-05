class CreateSavedFiles < ActiveRecord::Migration
  def change
    create_table :saved_files do |t|
      t.belongs_to :user, index: true
      t.text :description
      t.string :attachment
      t.timestamps
    end
  end
end
