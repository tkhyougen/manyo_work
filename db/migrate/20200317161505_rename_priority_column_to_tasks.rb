class RenamePriorityColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :priorty, :priority
  end
end
