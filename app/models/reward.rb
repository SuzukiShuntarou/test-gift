# frozen_string_literal: true

class Reward < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :users, through: :groups
  has_many :goals, dependent: :destroy

  accepts_nested_attributes_for :goals, allow_destroy: true

  def invite(current_user)
    return unless in_progress? && users.exclude?(current_user)

    users << current_user

    # 初期目標の作成
    goals.create(user_id: current_user.id, content: '', progress: 0)
    self.groups.each do |group|
      self.goals.each do |goal|
        goal.favorites.find_or_create_by(user_id: group.user_id).save
        goal.cheerings.find_or_create_by(user_id: group.user_id).save
      end
    end
  end

  def in_progress?
    # 登録した完了日当日までは実施中判定
    completiondate.after? Date.current.yesterday
  end
end
