class CreateMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :moves do |t|
      t.references :start, null: false, foreign_key: { to_table: :spaces }
      t.references :end, null: false, foreign_key: { to_table: :spaces }
      t.references :team, null: false, foreign_key: true
      t.references :piece, null: false, foreign_key: true

      t.timestamps
    end
  end
end
