class CreateLessons < ActiveRecord::Migration[8.1]

  def change
    create_table :lessons do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :tone
      t.datetime :liked_at
      t.datetime :dismissed_at
      t.timestamps
    end
  end

end
