class CheeringsController < ApplicationController
  def update
    @cheering = Cheering.find(params[:id])
    @cheering.increment!(:cheering_count)
  end
end
