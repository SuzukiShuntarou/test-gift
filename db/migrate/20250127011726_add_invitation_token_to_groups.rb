class AddInvitationTokenToGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :groups, :invitation_token, :string
  end
end
