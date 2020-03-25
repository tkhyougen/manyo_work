class AddPriority < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, 'integer USING CAST(priority AS integer)'
  end
end
