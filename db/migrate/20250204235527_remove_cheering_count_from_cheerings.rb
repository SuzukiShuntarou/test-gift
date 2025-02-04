class RemoveCheeringCountFromCheerings < ActiveRecord::Migration[7.2]
  def change
    remove_column :cheerings, :cheering_count, :integer
  end
end
