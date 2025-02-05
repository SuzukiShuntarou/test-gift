# frozen_string_literal: true

class RewardsController < ApplicationController
  before_action :set_reward, only: %i[edit update destroy]

  def show
    reward_id = params[:id]
    invitation_token = params[:invitation_token]
    if invitation_token
      @reward = Reward.includes(goals: :user).find_by!(id: reward_id, invitation_token:)
      @reward.invite(current_user)
    else
      groups = Group.includes(reward: { goals: %i[user favorites cheerings] }).where(user: current_user)
      @reward = groups.find_by!(reward_id:).reward
    end
    @goals = @reward.goals
  end

  def new
    @reward = Reward.new
    @reward.goals.build
  end

  def edit; end

  def create
    @reward = Reward.new(reward_and_goal_params)
    @reward.invitation_token ||= SecureRandom.urlsafe_base64
    @reward.goals.each { |goal| goal.user = current_user }

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

    redirect_to goals_path, notice: 'ご褒美の削除に成功！'
  end

  private

  def reward_params
    params.require(:reward).permit(:completiondate, :content, :location)
  end

  def reward_and_goal_params
    params.require(:reward).permit(:completiondate, :content, :location, goals_attributes: %i[content progress])
  end

  def set_reward
    @reward = current_user.groups.find_by!(reward_id: params[:id]).reward
  end
end
