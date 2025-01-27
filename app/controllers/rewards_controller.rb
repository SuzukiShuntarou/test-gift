class RewardsController < ApplicationController
  before_action :set_reward, only: %i[edit update destroy]

  def index
    @rewards = Reward.order(completiondate: :asc)
  end

  def show
    @reward = Reward.find(params[:id])
    # invite_user(@reward)
  end

  def new
    @reward = Reward.new
    @reward.goals.build
  end

  def edit
  end

  def create
    @reward = Reward.new(reward_and_goal_params)
    @reward.goals.each { |goal| goal.user_id = current_user.id }

    if @reward.save
      add_user(@reward)
      redirect_to @reward, notice: 'ご褒美の登録に成功！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @reward.update(reward_params)
      redirect_to reward_path(@reward.id), notice: 'ご褒美の編集に成功！'
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

  # 条件を付けないと無限に増える
  def add_user(reward)
    reward.users << current_user if !reward.users.include?(current_user)
  end

  
  # 招待アクション（仮）current_userが自分自身を追加する
  # showを呼び出したときに追加している。
  def invite_user(reward)
    if !reward.users.include?(current_user)
      reward.users << current_user 

      # 初期目標の作成
      @reward.goals.create(
        user_id: current_user.id,
        content: "",
        progress: 0
      )
    end
  end
end
