class CreateDeciderListItems < ActiveRecord::Migration[5.0]

  def change
    create_table :decider_list_items do |t|
      t.belongs_to :decider_list
      t.string :name
      t.datetime :picked_at
      t.timestamps
    end
  end

end
