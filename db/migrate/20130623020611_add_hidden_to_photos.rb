class AddHiddenToPhotos < ActiveRecord::Migration

  def change
    add_column :photos, :hidden, :boolean, default: false # rubocop:disable Rails/ThreeStateBooleanColumn
  end

end
