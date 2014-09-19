class MovePublicEntriesToPosts < ActiveRecord::Migration

  class EntryPhoto < ActiveRecord::Base
    belongs_to :entry
    belongs_to :photo
  end

  class PostPhoto < ActiveRecord::Base
    belongs_to :post
    belongs_to :photo
  end

  class Entry < ActiveRecord::Base
    has_many :comments
    has_many :entry_photos
    has_many :photos, through: :entry_photos
  end

  class Post < ActiveRecord::Base
    has_many :comments
    has_many :post_photos
    has_many :photos, through: :post_photos
  end

  def self.up
    say_with_time 'Moving public entries to posts' do
      Entry.where(public: true).find_each do |entry|
        post = Post.new({
          at: entry.at,
          body: entry.body,
          created_at: entry.created_at,
          updated_at: entry.updated_at,
        })
        entry.photos.each do |photo|
          post.photos << photo
        end
        entry.comments.each do |comment|
          post.comments << comment
        end
        post.save!
      end
    end
  end

  def self.down
    say_with_time 'Moving to posts public entries' do
      Post.find_each do |post|
        entry = Entry.new({
          public: true,
          at: post.at,
          body: post.body,
          created_at: post.created_at,
          updated_at: post.updated_at,
        })
        post.photos.each do |photo|
          entry.photos << photo
        end
        post.comments.each do |comment|
          entry.comments << comment
        end
        entry.save!
      end
    end
  end

end
