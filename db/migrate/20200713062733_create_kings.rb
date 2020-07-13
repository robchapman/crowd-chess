class CreateKings < ActiveRecord::Migration[6.0]
  def change
    create_table :kings do |t|

      t.timestamps
    end
  end
end
