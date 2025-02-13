# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :set_goal, only: %i[edit update]

  def edit; end

  def update
    if @goal.reward.in_progress? && @goal.update(goal_params)
      flash.now.notice = '目標の編集に成功！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :progress)
  end

  def set_goal
    @goal = current_user.goals.includes(:reward).find(params[:id])
  end
end
