class CheeringsController < ApplicationController
  def create
    @cheering = Cheering.find(params[:id])
    @cheering.increment!(:cheering_count)
  end
end
