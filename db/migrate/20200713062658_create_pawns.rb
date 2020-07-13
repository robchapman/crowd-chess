class CreatePawns < ActiveRecord::Migration[6.0]
  def change
    create_table :pawns do |t|

      t.timestamps
    end
  end
end
