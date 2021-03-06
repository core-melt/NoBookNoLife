class RelationshipsController < ApplicationController
  	before_action :authenticate_user!
	before_action :set_user

	#用途：フォローを作成
	def create
	    user = User.find(params[:follow_id])
	    following = current_user.follow(user)
		redirect_back(fallback_location: root_path)
	end

	#用途：フォローを削除
	def destroy
	    user = User.find(params[:follow_id])
	    following = current_user.unfollow(user)
        redirect_back(fallback_location: root_path)
	end

	#用途：フォロー一覧表示
	def follow
		@user = User.find(params[:follow_id])
		@users = @user.followings
	end

	#用途：フォロワー一覧表示
	def follower
		@user = User.find(params[:follow_id])
		@users = @user.followers
	end


  private

  def set_user
    user = User.find(params[:follow_id])
  end
end
