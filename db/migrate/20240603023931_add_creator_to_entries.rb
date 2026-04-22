class AddCreatorToEntries < ActiveRecord::Migration[6.1]

  def change
    add_reference :entries, :creator, null: true, foreign_key: { to_table: :users }, index: true
  end

end
