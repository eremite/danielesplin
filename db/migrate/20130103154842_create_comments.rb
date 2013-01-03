class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :entry
      t.belongs_to :user
      t.text :body
      t.timestamps
    end
    add_index :comments, :entry_id
    add_index :comments, :user_id
  end
end
