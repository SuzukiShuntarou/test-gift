# frozen_string_literal: true

class FavoritesController < ApplicationController
  def update
    @goal = Goal.includes(:favorites).find(params[:goal_id])
    @favorite = @goal.favorites.find_by(user_id: current_user.id)
    @favorite.good_count += 1
    @favorite.save! # バリデーションを含めて保存
  end
end
