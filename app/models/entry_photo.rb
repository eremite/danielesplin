class EntryPhoto < ActiveRecord::Base
  belongs_to :entry
  belongs_to :photo
  # attr_accessible :title, :body
end
