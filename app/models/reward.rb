class Reward < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :users, through: :groups
  has_many :goals, dependent: :destroy

  accepts_nested_attributes_for :goals, allow_destroy: true

  def invite(current_user)
    unless self.users.include?(current_user)
      self.users << current_user

      # 初期目標の作成
      goal = self.goals.create(user_id: current_user.id, content: "", progress: 0)
      goal.build_favorite.save
      goal.build_cheering.save
    end
  end

  def self.select_button_contents(display, current_user)
    rewards = Reward.includes(:users, goals: [:user, :favorite, :cheering]).where(users: { id: current_user.id }).order(completiondate: :asc)
    display == 'completed' ? rewards.where('completiondate < ?', Date.current) : rewards.where('completiondate >= ?', Date.current)
  end
end 
