class ChangePriority < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :priority
  end
end
