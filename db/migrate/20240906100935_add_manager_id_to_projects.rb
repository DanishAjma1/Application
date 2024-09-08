class AddManagerIdToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :manager_id, :integer
    add_foreign_key :projects, :users, column: :manager_id
  end
end
