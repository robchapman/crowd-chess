class AddAuthorToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :author, polymorphic: true, index: true, null: false
  end
end
