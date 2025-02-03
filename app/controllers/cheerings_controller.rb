# frozen_string_literal: true

class CheeringsController < ApplicationController
  def update
    @goal = Goal.find(params[:goal_id])
    @cheering = @goal.cheerings.find_by(user_id: current_user)
    @cheering.cheering_count += 1
    @cheering.save! # バリデーションを含めて保存
  end
end
