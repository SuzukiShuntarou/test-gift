# frozen_string_literal: true

class FavoritesController < ApplicationController
  def update
    @favorite = Favorite.find(params[:id])
    # @favorite.increment!(:good_count)
    @favorite.good_count += 1
    @favorite.save! # バリデーションを含めて保存
  end
end
