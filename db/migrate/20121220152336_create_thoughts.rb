class CreateThoughts < ActiveRecord::Migration
  def change
    create_table :thoughts do |t|
      t.belongs_to :user
      t.string :body
      t.date :on
      t.timestamps
    end
    add_index :thoughts, :user_id
  end
end
