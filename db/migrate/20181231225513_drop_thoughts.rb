class DropThoughts < ActiveRecord::Migration
  def change
    remove_index :thoughts, column: :user_id
    drop_table :thoughts do |t|
      t.belongs_to :user
      t.string :body
      t.date :on
      t.timestamps
    end
  end
end
