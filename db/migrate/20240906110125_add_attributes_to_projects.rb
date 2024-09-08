class AddAttributesToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :name, :string
    add_column :projects, :description, :text
    add_column :projects, :status, :string
  end
end
