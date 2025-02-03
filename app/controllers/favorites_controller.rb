# frozen_string_literal: true

class FavoritesController < ApplicationController
  def update
    @goal = Goal.find(params[:goal_id])
    @favorite = @goal.favorite
    @favorite.good_count += 1
    @favorite.save! # バリデーションを含めて保存
  end
end
