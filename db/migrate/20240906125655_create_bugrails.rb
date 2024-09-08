class CreateBugrails < ActiveRecord::Migration[7.2]
  def change
    create_table :bugrails do |t|
      t.string :generate
      t.string :model
      t.string :Bug
      t.string :title
      t.text :description
      t.integer :priority
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
