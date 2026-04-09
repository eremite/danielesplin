class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.belongs_to :user
      t.text :body
      t.datetime :at
      t.boolean :public, default: false # rubocop:disable Rails/ThreeStateBooleanColumn
      t.timestamps
    end
    add_index :entries, :user_id
  end
end
