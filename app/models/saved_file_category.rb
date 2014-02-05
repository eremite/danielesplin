class SavedFileCategory < ActiveRecord::Base

  has_many :saved_files

  scope :name_asc, -> { order(arel_table[:name].asc) }

end
