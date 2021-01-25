class CreateGameMasters < ActiveRecord::Migration[6.0]
  def change
    create_table :game_masters do |t|
      t.boolean :running

      t.timestamps
    end
  end
end
