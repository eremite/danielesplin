class AssignEntryPhotos < ActiveRecord::Migration

  class Photo < ActiveRecord::Base
  end

  class Entry < ActiveRecord::Base
    has_many :entry_photos
    has_many :photos, through: :entry_photos
  end

  class EntryPhoto < ActiveRecord::Base
    belongs_to :entry
    belongs_to :photo
  end

  def up
    Entry.find_each do |entry|
      t = Photo.arel_table
      conditions = t[:at].in(entry.at.beginning_of_day..entry.at.end_of_day).and(t[:entry_id].eq(nil))
      conditions = conditions.or(t[:entry_id].eq(entry.id))
      entry.photos << Photo.where(conditions)
    end
  end

  def down
    EntryPhoto.delete_all
  end
end
