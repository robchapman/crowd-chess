class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.integer :row
      t.integer :column
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
