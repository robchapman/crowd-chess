class AddTeamToChannel < ActiveRecord::Migration[6.0]
  def change
    add_reference :channels, :team, null: false, foreign_key: true
  end
end
