class CreateBabyLogs < ActiveRecord::Migration
  def change
    create_table :baby_logs do |t|
      t.datetime :at
      t.string :kind
      t.belongs_to :user
      t.text :notes
      t.timestamps
    end
    add_index :baby_logs, :user_id
  end
end
