# frozen_string_literal: true

class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :reward
  has_many :favorites, dependent: :destroy
  has_many :cheerings, dependent: :destroy

  def self.search_rewards_completed_or_in_progress(display, current_user)
    goals = Goal.includes(:reward)
                .where(user_id: current_user.id)
                .order('rewards.completiondate ASC, rewards.id ASC')
    if display == 'completed'
      goals.where(rewards: { completiondate: ...Date.current }).reverse
    else
      goals.where(rewards: { completiondate: Date.current.. })
    end
  end
end
