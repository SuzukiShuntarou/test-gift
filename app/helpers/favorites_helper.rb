# frozen_string_literal: true

module FavoritesHelper
  def show_liking_count(goal)
    display = goal.favorites.includes(:user).map do |favorite|
      if favorite.good_count > 0
        "#{favorite.user.name}さんが#{favorite.good_count}回"
      end
    end

    if display.compact.empty?
      "頑張る人にひと押し、いいねボタンでさりげなく褒めてみて！"
    else
      "#{display.compact.join('、')}褒めてくれたよ！"
    end
  end
end

