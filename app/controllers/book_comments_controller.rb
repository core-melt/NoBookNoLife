class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
  	unless params[:comment].blank? && params[:child_comment].blank?
	  	book = Book.find(params[:book_id])
	  	comment = book.comments.new(user_id: current_user.id)
	  	comment[:comment] = params[:comment].blank? ? params[:child_comment] : params[:comment]
	  	comment.save

	  	# 子コメントの場合の処理
	  	if params[:comment].blank?
	  		child_comments = ChildComments.new(comment_id: comment.id)
	  		child_comments.save
		end
	end
	binding.pry
  end
end
