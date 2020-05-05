class Dropmiddlelabels < ActiveRecord::Migration[5.2]
  def change
    drop_table :middlelabels
  end
end
