class RewardsController < ApplicationController
  before_action :set_reward, only: %i[show edit update destroy]

  def index
    # @rewards = Reward.order(completiondate: :asc)
    @rewards = Reward.joins(:users)
                 .where(users: { id: current_user.id })
                 .order(completiondate: :asc)
  end

  def show
    # URLに invitation_token がない場合はDB検索しないようにする
    if params[:invitation_token] && @reward == Reward.find_by(invitation_token: params[:invitation_token])
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
    end
    if @reward.save
      @reward.users << current_user
      redirect_to @reward, notice: 'ご褒美の登録に成功！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @reward.update(reward_params)
      flash.now.notice = 'ご褒美の編集に成功！'
    else
      render :edit, status: :unprocessable_entity
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

  def reward_and_goal_params
    params.require(:reward).permit(:completiondate ,:content ,:location, goals_attributes: %i[content progress])
  end

  def set_reward
    @reward = Reward.find(params[:id])
  end
end
