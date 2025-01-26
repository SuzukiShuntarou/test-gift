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
      # これで既存ユーザにも送信できるが毎回パスワードを変える必要がある。
      user.invite!
      redirect_to user_path(current_user.id)
    else
      # ここで新規ユーザはDBにはいるので、invitation_tokenが生きている間にもう一度送信があるとuser.present?がtrueとなる
      user = User.invite!(email: email)
      invitation_token = user.raw_invitation_token
      redirect_to user_path(current_user.id, invitation_token: invitation_token)
    end
  end

  def edit
    # @invitation_token = params[:invitation_token]
    super
  end

  def update
    super
  end

  def destroy
    super
  end
end
