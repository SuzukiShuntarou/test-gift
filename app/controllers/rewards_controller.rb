class RewardsController < ApplicationController
  before_action :set_reward, only: %i[destroy]

  def index
    @rewards = Reward.order(completiondate: :asc)
  end

  def show
    @reward = Reward.find(params[:id])
  end

  def new
    @reward = Reward.new
  end

  def edit
  end

  def create
    @reward = Reward.new(reward_params)

    if @reward.save
      @reward.users << current_user
      redirect_to @reward, notice: 'ご褒美の登録に成功！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @reward.destroy

    redirect_to rewards_path, notice: 'ご褒美の削除に成功！'
  end

  private

  def reward_params
    params.require(:reward).permit(:completiondate ,:content ,:location)
  end

  def set_reward
    @reward = Reward.find(params[:id])
  end
end
