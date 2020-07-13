class CreateQueens < ActiveRecord::Migration[6.0]
  def change
    create_table :queens do |t|

      t.timestamps
    end
  end
end
