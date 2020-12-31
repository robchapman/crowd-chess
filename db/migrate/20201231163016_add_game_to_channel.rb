class AddGameToChannel < ActiveRecord::Migration[6.0]
  def change
    add_reference :channels, :game, null: false, foreign_key: true
  end
end
