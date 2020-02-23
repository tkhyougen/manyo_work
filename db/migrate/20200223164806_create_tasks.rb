class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :detail
      t.date :due
      t.integer :priority
      t.integer :status
      t.string :label

      t.timestamps
    end
  end
end
