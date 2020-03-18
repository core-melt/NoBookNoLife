class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Devise::Controllers::Helpersのメソッドをオーバーライド
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    root_path
  end

  # ISBNによる検索
  def get_json_from_isbn(isbn)
    client = HTTPClient.new
    request =  client.get('https://www.googleapis.com/books/v1/volumes?q=isbn:' + isbn)
    response = JSON.parse(request.body)
    return response
  end

  # View側からでも使用できるようにする
  helper_method :get_json_from_isbn

  protected
  def configure_permitted_parameters
    added_attrs = [ :email, :nickname, :password, :spoiler_prevention ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
