class AddViewedBlogAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :viewed_blog_at, :datetime
  end
end
