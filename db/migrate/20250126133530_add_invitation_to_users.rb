class AddInvitationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :invite_digest, :string
    add_column :users, :invite_sent_at, :datetime
  end
end
