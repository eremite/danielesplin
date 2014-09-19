class RemovePublicFromEntries < ActiveRecord::Migration
  def change
    remove_column :entries, :public, :boolean
  end
end
