class AddEmbeddingToEntries < ActiveRecord::Migration[8.1]

  def change
    add_column :entries, :embedding, :json
  end

end
