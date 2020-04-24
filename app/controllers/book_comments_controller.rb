class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
  	unless params[:comment].blank? && params[:child_comment].blank?
	  	@book = Book.find(params[:book_id])
	  	comment = @book.comments.new(user_id: current_user.id)
	  	comment[:comment] = params[:comment].blank? ? params[:child_comment] : params[:comment]
	  	comment[:spoiler] = params[:spoiler]
	  	comment.score = Language.get_data(comment[:comment])
	  	comment.save

	  	# 子コメントの場合の処理
	  	if params[:comment].blank?
	  		child_comments = ChildComment.new(parent_id: params[:parent_id], comment_id: comment.id)
  			child_comments.save
		end

		#非同期用
		comments = @book.comments.order(created_at: "DESC")
		@comments = comments.page(params[:page])
	else
		redirect_back(fallback_location: root_path)
	end
  end
end
