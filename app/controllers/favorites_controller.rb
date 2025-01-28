class FavoritesController < ApplicationController
  def create
    favorite = Favorite.find(params[:id])
    favorite.increment!(:good_count)
    redirect_to request.referer
  end
end
