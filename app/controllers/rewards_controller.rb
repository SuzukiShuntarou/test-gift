class RewardsController < ApplicationController
  before_action :set_reward, only: %i[edit update destroy]

  def index
    @rewards = Reward.search_completed_or_in_progress(params[:display], current_user)
  end

  def show
    @reward = Reward.includes(goals: [:user, :favorite, :cheering]).find(params[:id])
    @goals = @reward.goals
    if params[:invitation_token] && @reward.invitation_token == params[:invitation_token]
      @reward.invite(current_user) 
    end
  end

  def new
    @reward = Reward.new
    @reward.goals.build
  end

  def edit
  end

  def create
    @reward = Reward.new(reward_and_goal_params)
    @reward.invitation_token ||= SecureRandom.urlsafe_base64 
    @reward.goals.each do |goal|
      goal.user_id = current_user.id
      goal.build_favorite
      goal.build_cheering
    end

    if @reward.save
      @reward.users << current_user
      redirect_to @reward, notice: 'ご褒美の登録に成功！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @reward.in_progress? && @reward.update(reward_params)
      flash.now.notice = 'ご褒美の編集に成功！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reward.destroy if @reward.in_progress?

    redirect_to rewards_path, notice: 'ご褒美の削除に成功！'
  end

  private

  def reward_params
    params.require(:reward).permit(:completiondate ,:content ,:location)
  end

  def reward_and_goal_params
    params.require(:reward).permit(:completiondate ,:content ,:location, goals_attributes: %i[content progress])
  end

  def set_reward
    @reward = Reward.find(params[:id])
  end
end
