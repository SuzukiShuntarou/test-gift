class AddUserIdToFavorites < ActiveRecord::Migration[7.2]
  def change
    add_reference :favorites, :user, null: false, foreign_key: true
  end
end
