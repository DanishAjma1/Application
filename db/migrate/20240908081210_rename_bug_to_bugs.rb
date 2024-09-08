class RenameBugToBugs < ActiveRecord::Migration[7.2]
  def change
    rename_table :bug, :bugs
  end
end
