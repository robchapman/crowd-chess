class AddPlayertoPlays < ActiveRecord::Migration[6.0]
  def change
    add_reference :plays, :player, polymorphic: true, index: true, null: false
  end
end
