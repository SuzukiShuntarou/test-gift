# frozen_string_literal: true

module FavoritesHelper
  def show_user_count(goal)
    goal.favorites.includes(:user).map do |favorite|
      user = favorite.user
      "#{user.name}さんが#{favorite.good_count}回"
    end
  end
end
