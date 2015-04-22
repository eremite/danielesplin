class AddKindToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :kind, :string
  end
end
