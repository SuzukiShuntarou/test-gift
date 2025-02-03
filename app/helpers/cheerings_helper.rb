# frozen_string_literal: true

module CheeringsHelper
  def show_user_count(goal)
    goal.cheerings.includes(:user).map do |cheering|
      user = cheering.user
      "#{user.name}さんが#{cheering.cheering_count}回"
    end
  end
end
