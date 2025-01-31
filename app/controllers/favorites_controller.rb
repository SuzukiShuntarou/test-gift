# frozen_string_literal: true

class FavoritesController < ApplicationController
  def update
    @favorite = Favorite.find(params[:id])
    @favorite.increment!(:good_count)
  end
end
