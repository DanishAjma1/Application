class RemoveMultipleAttributesFrombug < ActiveRecord::Migration[7.2]
  def change
      remove_column :bug, :generate, :string
    remove_column :bug, :model, :string
    remove_column :bug, :Bug, :string
  end
end
