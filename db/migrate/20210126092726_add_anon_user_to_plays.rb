class AddAnonUserToPlays < ActiveRecord::Migration[6.0]
  def change
    add_reference :plays, :anon_user, index: true, foreign_key: true, null: true
  end
end
