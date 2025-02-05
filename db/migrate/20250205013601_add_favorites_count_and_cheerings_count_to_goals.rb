class AddFavoritesCountAndCheeringsCountToGoals < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :favorites_count, :integer, default: 0
    add_column :goals, :cheerings_count, :integer, default: 0
  end
end
