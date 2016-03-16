class AddMetaToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :meta, :text
  end
end
