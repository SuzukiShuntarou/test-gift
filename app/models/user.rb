class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :groups, dependent: :destroy
  has_many :rewards, through: :groups
  has_many :goals, dependent: :destroy

  def invite_reward(reward)
    if !reward.users.include?(current_user)
      reward.users << current_user 

      # 初期目標の作成
      reward.goals.create(
        user_id: current_user.id,
        content: "",
        progress: 0
      )
    end
  end
end
