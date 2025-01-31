# frozen_string_literal: true

class CheeringsController < ApplicationController
  def update
    @cheering = Cheering.find(params[:id])
    # @cheering.increment!(:cheering_count)
    @cheering.cheering_count += 1
    @cheering.save! # バリデーションを含めて保存
  end
end
