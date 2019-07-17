class CreateTaskLists < ActiveRecord::Migration[5.2]
  def change
    create_table :task_lists do |t|
      t.string :title, null: false
      t.boolean :open, default: false, null: false
      t.boolean :favorite, default: false, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
