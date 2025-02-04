class RemoveGoodCountFromFavorites < ActiveRecord::Migration[7.2]
  def change
    remove_column :favorites, :good_count, :integer
  end
end
