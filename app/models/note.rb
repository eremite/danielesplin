class Note < ApplicationRecord

  acts_as_taggable_on :note_tags

  belongs_to :user

end
