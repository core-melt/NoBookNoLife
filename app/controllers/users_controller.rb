class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user?, except: [:show]

  def show
  	@user = User.find(params[:id])

    @chart = {}
    cnt = 0
    @user.readings.select(:created_at).each do |readed_day|
      cnt += 1
      @chart.store(readed_day.created_at.strftime("%Y-%m-%d"), cnt)
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
  	@user = User.find(current_user.id)

    # パスワードが空ならパスワードは更新しない
    if params[:user][:password].blank?
      params[:user].delete("password")
    end

  	if @user.update(user_permitted_parameters)
  		redirect_to user_path(current_user.id)
  	else
  		render action: :edit
  	end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path
  end



  private
  def user_permitted_parameters
    added_attrs = [ :email, :nickname, :password, :profile_image, :introduction, :spoiler_prevention ]
    params.require(:user).permit(added_attrs)
  end

  def current_user?
    if current_user != User.find(params[:id])
      redirect_back(fallback_location: root_path)
    end
  end
end
