class ChangeColumnToDue < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :due, :date , null:false
  end
end
