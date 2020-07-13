class CreateBishops < ActiveRecord::Migration[6.0]
  def change
    create_table :bishops do |t|

      t.timestamps
    end
  end
end
