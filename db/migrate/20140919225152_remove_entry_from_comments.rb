class RemoveEntryFromComments < ActiveRecord::Migration
  def change
    remove_reference :comments, :entry, index: true
  end
end
