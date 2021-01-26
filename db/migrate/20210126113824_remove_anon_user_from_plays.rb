class RemoveAnonUserFromPlays < ActiveRecord::Migration[6.0]
  def change
    remove_reference :plays, :anon_user, index: true, foreign_key: true, null: true
  end
end
