class CreateAnonUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :anon_users do |t|
      t.string :nickname

      t.timestamps
    end
  end
end
