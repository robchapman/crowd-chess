class ChangeColumnOnMessage < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :user_id, :bigint, null: true
  end
end
