class RemoveUserFromPlays < ActiveRecord::Migration[6.0]
  def change
    remove_reference :plays, :user, null: false, foreign_key: true
  end
end
