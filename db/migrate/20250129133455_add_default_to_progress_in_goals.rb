class AddDefaultToProgressInGoals < ActiveRecord::Migration[7.2]
  def change
    change_column_default :goals, :progress, 0
  end
end
