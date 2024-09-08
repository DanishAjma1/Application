class AddQaIdToBug < ActiveRecord::Migration[7.2]
  def change
    add_column :bug, :qa_id, :integer
    add_foreign_key :bug, :users, column: :qa_id
  end
end
