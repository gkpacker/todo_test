class AddSubtaskToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :subtask, :string
  end
end
