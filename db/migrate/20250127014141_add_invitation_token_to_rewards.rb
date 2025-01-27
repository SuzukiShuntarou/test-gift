class AddInvitationTokenToRewards < ActiveRecord::Migration[7.2]
  def change
    add_column :rewards, :invitation_token, :string
  end
end
