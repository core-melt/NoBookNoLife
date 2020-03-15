class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(current_user.id)
  end

  def update
  	@user = User.find(current_user.id)
  	if @user.update(user_permitted_parameters)
  		redirect_to user_path(current_user.id)
  	else
  		render action: :edit
  	end
  end

  def destroy
  end



  private
  def user_permitted_parameters
    added_attrs = [ :email, :nickname, :password, :profile_image, :introduction, :spoiler_prevention ]
    params.require(:user).permit(added_attrs)
  end
end
