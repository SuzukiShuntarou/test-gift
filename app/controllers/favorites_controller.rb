class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.find(params[:id])
    @favorite.increment!(:good_count)
  end
end
