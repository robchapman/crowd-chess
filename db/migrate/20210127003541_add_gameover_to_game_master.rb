class AddGameoverToGameMaster < ActiveRecord::Migration[6.0]
  def change
    add_column :game_masters, :gameover, :boolean
  end
end
