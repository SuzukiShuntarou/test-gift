# frozen_string_literal: true

module FavoritesHelper
  def show_liking_count(goal)
    user_names = goal.favorites.includes(:user).pluck('users.name').uniq

    if user_names.empty?
      '頑張る人にひと押し、いいねボタンでさりげなく褒めてみて！'
    else
      "#{user_names.join('と')}が褒めてくれたよ！"
    end
  end
end
