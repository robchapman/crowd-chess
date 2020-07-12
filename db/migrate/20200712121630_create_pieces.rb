class CreatePieces < ActiveRecord::Migration[6.0]
  def change
    create_table :pieces do |t|
      t.string :type
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
