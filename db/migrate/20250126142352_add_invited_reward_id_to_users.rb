class AddInvitedRewardIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :invited_reward_id, :integer
  end
end
