class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Devise::Controllers::Helpersのメソッドをオーバーライド
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  protected
  def configure_permitted_parameters
    added_attrs = [ :email, :nickname, :password, :profile_image_id, :introduction, :sex, :spoiler_prevention ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
