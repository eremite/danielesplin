class AddQuestionsToLessons < ActiveRecord::Migration[8.1]

  def change
    add_column :lessons, :question, :string
  end

end
