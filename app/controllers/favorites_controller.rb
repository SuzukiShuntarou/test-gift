# frozen_string_literal: true

class FavoritesController < ApplicationController
  def create
    @goal = Goal.find(params[:goal_id])
    @favorite = @goal.favorites.build(user: current_user)
    @favorite.save!
  end
end
