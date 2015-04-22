class AddFinishedAtToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :finished_at, :datetime
  end
end
