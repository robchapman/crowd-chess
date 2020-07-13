class CreateKnights < ActiveRecord::Migration[6.0]
  def change
    create_table :knights do |t|

      t.timestamps
    end
  end
end
