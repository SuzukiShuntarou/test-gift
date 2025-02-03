class AddUserIdToCheerings < ActiveRecord::Migration[7.2]
  def change
    add_reference :cheerings, :user, null: false, foreign_key: true
  end
end
