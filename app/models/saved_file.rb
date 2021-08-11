class SavedFile < ApplicationRecord

  has_one_attached :attachment

  belongs_to :user
  belongs_to :saved_file_category

  scope :created_at_desc, -> { order(arel_table[:created_at].desc) }

end
