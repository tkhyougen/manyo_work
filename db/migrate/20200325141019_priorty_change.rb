class PriortyChange < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :priority
    # add_column :tasks, :priorty, 'integer USING CAST(priority AS integer)'
  end
end
