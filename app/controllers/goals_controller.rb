class GoalsController < ApplicationController
  before_action :set_goal, only: %i[edit update]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      flash.now.notice = '目標の編集に成功！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:content ,:progress)
  end

  def set_goal
    @goal = current_user.goals.find(params[:id])
  end
end
