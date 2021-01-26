class RemoveTeamFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :team, foreign_key: true
  end
end
