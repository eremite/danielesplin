class AddAttachmentImageToPhotos < ActiveRecord::Migration
  # Commented out because paperclip is no longer installed...
  def self.up
    # change_table :photos do |t|
    #   t.has_attached_file :image
    # end
  end

  def self.down
    # drop_attached_file :photos, :image
  end
end
