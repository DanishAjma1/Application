class RenameBugrailsToBug < ActiveRecord::Migration[7.2]
  def change
        rename_table :bugrails, :bug
  end
end
