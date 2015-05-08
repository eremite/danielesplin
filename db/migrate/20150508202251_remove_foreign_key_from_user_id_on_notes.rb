class RemoveForeignKeyFromUserIdOnNotes < ActiveRecord::Migration
  def change
    remove_foreign_key :notes, :user
  end
end
