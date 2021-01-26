class AddTeamToPlays < ActiveRecord::Migration[6.0]
  def change
    add_reference :plays, :team, index: true, foreign_key: true, null: false
  end
end
