class CreateNutritionalPosts < ActiveRecord::Migration
  def change
    create_table :nutritional_posts do |t|
      t.string :title
      t.string :slug
      t.datetime :published_at
      t.text :bite
      t.text :full_plate
      t.timestamps
    end
  end
end
