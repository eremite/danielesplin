class AddBornAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :born_at, :datetime
  end
end
