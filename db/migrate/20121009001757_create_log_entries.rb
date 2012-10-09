class CreateLogEntries < ActiveRecord::Migration
  def change
    create_table :log_entries do |t|
      t.belongs_to :user
      t.string :action
      t.timestamps
    end
    add_index :log_entries, :user_id
  end
end
