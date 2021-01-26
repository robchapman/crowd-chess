class RemoveAnonUserFromMessages < ActiveRecord::Migration[6.0]
  def change
    remove_reference :messages, :anon_user, index: true, foreign_key: true, null: true
  end
end
