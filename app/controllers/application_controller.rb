class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])

    # 招待用パラメータ
    devise_parameter_sanitizer.permit(:invite) do |u|
      u.permit(:email, :reward_id, :invited_reward_id)
    end
    
    # 招待を承認する際のパラメータ
    devise_parameter_sanitizer.permit(:accept_invitation) do |u|
      u.permit(:password, :password_confirmation, :invitation_token, :name, :invited_reward_id, :email)
    end
  end
end
