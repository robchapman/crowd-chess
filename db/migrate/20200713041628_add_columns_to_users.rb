class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :chat_colour, :string
    add_column :users, :nickname, :string
    add_reference :users, :team, foreign_key: true
  end
end
