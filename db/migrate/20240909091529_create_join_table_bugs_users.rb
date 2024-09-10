class CreateJoinTableBugsUsers < ActiveRecord::Migration[7.2]
  def change
    create_join_table :bugs, :users do |t|
      t.index [ :bug_id, :user_id ]
      t.index [ :user_id, :bug_id ]
    end
  end
end
