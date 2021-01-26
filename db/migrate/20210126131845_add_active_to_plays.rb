class AddActiveToPlays < ActiveRecord::Migration[6.0]
  def change
    add_column :plays, :active, :boolean, null: false
  end
end
