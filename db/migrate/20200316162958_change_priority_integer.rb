class ChangePriorityInteger < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priorty, :integer, after: :due, default:0
  end
end
