class Users::InvitationsController < Devise::InvitationsController
  def new
    super
  end

  def create
    email = params[:user][:email]
    reward_id = params[:user][:reward_id]

    # 既存ユーザの処理
    user = User.find_by(email: email)
    if user.present?
      user.invited_reward_id = reward_id
      user.invite!
      redirect_to user_path(current_user.id)
    else
      # ここで新規ユーザはDBにはいるので、invitation_tokenが生きている間にもう一度送信があるとuser.present?がtrueとなる
      user = User.invite!(email: email, invited_reward_id: reward_id)
      redirect_to user_path(current_user.id)
    end
  end

  def edit
    email = params[:email]
    reward = Reward.find(params[:invited_reward_id])
    user = User.find_by(email: email)
    redirect_to rewards_path(reward.id)
    # current_user.invite_reward(reward) # ログインしていないとcurrent_userはnilなのでできない
    # super
  end

  def update
    super
  end

  def destroy
    super
  end
end
